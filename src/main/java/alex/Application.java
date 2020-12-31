package alex;

import alex.entity.GoodsEntity;
import alex.lib.Helper;
import alex.lib.ScheduledTasks;
import alex.lib.ShutdownThread;
import org.hibernate.annotations.NotFound;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.Environment;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.io.File;
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
    private static AtomicLong orderId;
    private static StringRedisTemplate redisTemplate;
    private static String redisSessionNamespace;

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
    }

    public static String getAppDir() {
        return appDir;
    }

    public static ConfigurableApplicationContext getContext() {
        return context;
    }

    @NotFound
    public static JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public static StringRedisTemplate getRedisTemplate() {
        return redisTemplate;
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

    @Autowired
    private void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        Application.jdbcTemplate = jdbcTemplate;
        var g = jdbcTemplate.query("select * from goods", new GoodsEntity());
        var id = jdbcTemplate.queryForList("SELECT MAX(id) as id FROM orders").get(0).get("id");
        Application.orderId = id == null ? new AtomicLong(0L) : new AtomicLong(Helper.longValue(id));
    }

    @Autowired
    private void setRedisTemplate(StringRedisTemplate redisTemplate) {
        Application.redisTemplate = redisTemplate;
    }
}
