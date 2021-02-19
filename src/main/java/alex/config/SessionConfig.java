package alex.config;

import alex.authentication.UserToken;
import alex.lib.Helper;
import alex.lib.session.ApiSession;
import alex.lib.session.Session;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Objects;

/**
 * session config
 * session 加载规则在 GlobalAuth 中配置
 */
@Component
public class SessionConfig {

    private final Log log = LogFactory.getLog(this.getClass());

    /**
     * 定时检查清理session/api session数据
     * 每天00:40 12:40 各运行一次
     */
    @Scheduled(cron = "0 40 0,12 * * *")
    public void cleanTemplateFiles() {
        log.info("clean session data");

        var redisTemplate = RedisConfig.getStringObjectRedisTemplate();
        long ttl, timeout = Session.TIMEOUT.toSeconds();
        for (String key : Objects.requireNonNull(redisTemplate.keys(Session.REDIS_PREFIX + "*"))) {
            ttl = Helper.longValue(redisTemplate.getExpire(key));
            if (key.length() < 20 || ttl == -1L || ttl > timeout) {
                redisTemplate.delete(key);
            }
        }

        // 清理 api session
        timeout = ApiSession.TIMEOUT.toSeconds();
        for (String key : Objects.requireNonNull(redisTemplate.keys(ApiSession.REDIS_PREFIX + "*"))) {
            ttl = Helper.longValue(redisTemplate.getExpire(key));
            if (key.length() < 20 || ttl == -1L || ttl > timeout
                    // 清理未登录,存在时长超过session timeout的会话
            || (redisTemplate.opsForHash().get(key, UserToken.NAME) == null && timeout - ttl > Session.TIMEOUT.toSeconds())) {
                redisTemplate.delete(key);
            }
        }
    }
}
