package alex.lib.session;

import alex.config.RedisConfig;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

/**
 * session 实现，用于替换系统session机制
 * 相关配置等在 GlobalAuth SessionConfig 中实现
 */
public class Session implements BaseSession {
    // cooke name
    public static String COOKIE_NAME = "sid";

    //redis prefix
    public static String REDIS_PREFIX = "sid:";
    // 过期时间
    public static Duration TIMEOUT = Duration.ofHours(6);

    private final HttpServletResponse response;
    // session id
    private String id;

    /**
     * create session object
     *
     * @param request  request
     * @param response response
     */
    public Session(HttpServletRequest request, HttpServletResponse response) {

        this.response = response;
        var cookies = request.getCookies();
        if (cookies != null) {
            for (var cookie : cookies) {
                if (cookie.getName().equals(COOKIE_NAME)) {
                    id = cookie.getValue();
                    break;
                }
            }
            if (id != null && !flush()) {
                id = null;
            }
        }
        request.setAttribute(Session.class.getSimpleName(), this);
    }

    public static Session from(HttpServletRequest request) {
        var obj = request.getAttribute(Session.class.getSimpleName());
        return (Session) obj;
    }


    /**
     * delete
     */
    @Override
    public void destroy() {
        if (id != null) {
            RedisConfig.getStringObjectRedisTemplate().delete(REDIS_PREFIX + id);
        }

    }

    /**
     * 刷新过期时间
     */
    private boolean flush() {
        if (id != null) {
            Boolean b = RedisConfig.getStringObjectRedisTemplate().expire(REDIS_PREFIX + id, TIMEOUT);
            if (b != null) {
                return b;
            }
        }
        return false;
    }


    public Object get(String key) {
        return id == null ? null : RedisConfig.getStringObjectRedisTemplate().opsForHash().get(REDIS_PREFIX + id, key);
    }

    /**
     * 返回所有键值对
     *
     * @return map
     */
    @Override
    public Map<String, Object> getAll() {
        Map<String, Object> map = new HashMap<>();
        if (id != null) {
            RedisConfig.getStringObjectRedisTemplate().opsForHash().entries(REDIS_PREFIX + id).
                    forEach((key, val) -> {
                        if (key instanceof String) {
                            map.put((String) key, val);
                        }
                    });
        }
        return map;
    }


    /**
     * 获取session id
     *
     * @param canCreate 不存在则新建
     * @return session id
     */
    @Override
    public String getId(boolean canCreate) {
        if (id == null && canCreate) {
            id = BaseSession.generalId();
            RedisConfig.getStringObjectRedisTemplate().opsForHash().put(REDIS_PREFIX + id, "sessionId", id);
            flush();
            Cookie cookie = new Cookie(COOKIE_NAME, id);
            cookie.setHttpOnly(true);
            cookie.setPath("/");
            response.addCookie(cookie);
        }
        return id;
    }

    @Override
    public void delete(String key) {
        if (id != null) {
            RedisConfig.getStringObjectRedisTemplate().opsForHash().delete(REDIS_PREFIX + id, key);
        }
    }

    /**
     * 设置键值对
     *
     * @param key   string
     * @param value object
     */
    public void set(String key, Object value) {
        RedisConfig.getStringObjectRedisTemplate().opsForHash().put(REDIS_PREFIX + getId(true), key, value);
    }
}