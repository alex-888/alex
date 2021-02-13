package alex;

import alex.lib.Helper;
import alex.lib.ScheduledTasks;
import alex.lib.ShutdownThread;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.core.env.Environment;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;

import java.io.File;
import java.io.IOException;
import java.util.concurrent.atomic.AtomicLong;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


@EnableScheduling
@SpringBootApplication
public class Application {
    // application dir
    private static String appDir;
    private static ConfigurableApplicationContext context;
    private static JdbcTemplate jdbcTemplate;
    // 404错误默认内容
    private static String notFoundContent;
    private static AtomicLong orderId;
    private static StringRedisTemplate redisTemplate;
    private static String redisSessionNamespace;

    public static String getAppDir() {
        return appDir;
    }

    public static ConfigurableApplicationContext getContext() {
        return context;
    }

    public static JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    @Autowired
    private void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        Application.jdbcTemplate = jdbcTemplate;
        var id = jdbcTemplate.queryForList("SELECT MAX(id) as id FROM orders").get(0).get("id");
        Application.orderId = id == null ? new AtomicLong(0L) : new AtomicLong(Helper.longValue(id));

        // init notFoundContent
        try {
            ClassPathResource resource = new ClassPathResource("/static/error/404.html");
            notFoundContent = new String(resource.getInputStream().readAllBytes()).intern();
        } catch (IOException e) {
            e.printStackTrace();
            notFoundContent = "404 File Not Found";
        }
    }

    public static String getNotFoundContent() {
        return notFoundContent;
    }

    public static StringRedisTemplate getRedisTemplate() {
        return redisTemplate;
    }

    @Autowired
    private void setRedisTemplate(StringRedisTemplate redisTemplate) {
        Application.redisTemplate = redisTemplate;
    }

    public static String getRedisSessionNamespace() {
        return redisSessionNamespace;
    }

    public static AtomicLong getOrderId() {
        return orderId;
    }

    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(Application.class);
        app.setBannerMode(Banner.Mode.OFF);
        app.run(args);
    }

    /**
     * init application dir
     */
    private void initAppDir() {
        String path = Application.class.getProtectionDomain().getCodeSource().getLocation().toString();
        Pattern pattern = Pattern.compile("^jar:file:(.+?)!");
        Matcher matcher = pattern.matcher(path);
        if (matcher.find()) {
            String os = System.getProperty("os.name").toLowerCase();
            String dir = matcher.group(1);
            if (os.contains("win") && dir.charAt(0) == '/') {
                dir = dir.substring(1);
            }
            pattern = Pattern.compile("^(.*)([\\\\/])");
            matcher = pattern.matcher(dir);
            if (matcher.find()) {
                if (os.contains("win")) {
                    appDir = matcher.group(1).replace("/", "\\") + "\\";
                }
                appDir = matcher.group(1) + "/";
            } else {
                Logger LOGGER = LoggerFactory.getLogger(Application.class);
                LOGGER.error(String.format("not found application dir: %s", dir));
                System.exit(-1);
            }

        } else {
            appDir = System.getProperty("user.dir") + File.separator;
        }
        appDir = appDir.intern();
    }

    @Autowired
    private void setConfigurableApplicationContext(ConfigurableApplicationContext context) {
        initAppDir();
        Application.context = context;
        Environment env = context.getEnvironment();
        redisSessionNamespace = env.getProperty("spring.session.redis.namespace", "spring:session:");
        Runtime.getRuntime().addShutdownHook(new ShutdownThread());
        ScheduledTasks scheduledTasks = context.getBean(ScheduledTasks.class);
        scheduledTasks.cleanTemplateFiles();
    }

    /**
     * 注册TaskScheduler
     *
     * @return taskScheduler
     */
    @Bean
    TaskScheduler scheduledExecutorService() {
        ThreadPoolTaskScheduler scheduler = new ThreadPoolTaskScheduler();
        scheduler.setPoolSize(4);
        scheduler.setThreadNamePrefix("scheduled-thread-");
        return scheduler;
    }
}
