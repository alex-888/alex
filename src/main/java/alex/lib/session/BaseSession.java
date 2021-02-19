package alex.lib.session;

import org.apache.commons.codec.binary.Hex;

import java.security.SecureRandom;
import java.util.Map;

/**
 * session interface
 */
public interface BaseSession {
    /**
     * 销毁会话信息
     */
    void destroy();

    /**
     * get value by ke
     * @param key session key
     * @return session value
     */
    Object get(String key);

    /**
     * get all data
     * @return all data
     */
    Map<String, Object> getAll();

    /**
     * 获取session id
     * @param canCreate create if not exist
     * @return session
     */
    String getId(boolean canCreate);

    /**
     * delete key
     * @param key key
     */
    void delete(String key);

    /**
     * set key value
     * @param key session key
     * @param value session value
     */
    void set(String key, Object value);

    /**
     * 生成 session id
     * @return session id
     */
    static String generalId() {
        return Hex.encodeHexString(SecureRandom.getSeed(32));
    }

}
