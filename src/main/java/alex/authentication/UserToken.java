package alex.authentication;

import alex.Application;
import alex.entity.UserEntity;
import alex.lib.Helper;
import alex.lib.session.Session;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.hibernate.internal.util.SerializationHelper;
import org.springframework.data.redis.connection.RedisConnection;

import javax.servlet.http.HttpSession;
import java.io.ByteArrayInputStream;
import java.io.ObjectInputStream;
import java.util.Objects;
import java.util.Set;

public class UserToken extends Token {
    public final static String NAME = "userToken";
    public final static String REDIS_USER_PREFIX = "user:";

    public UserToken() {
    }

    public UserToken(UserEntity userEntity) {
        super(userEntity);
    }


    public static void deleteToken(long uid, String redisKey) {
        Application.getRedisTemplate().delete(redisKey);
        Application.getRedisTemplate().opsForSet().remove(REDIS_USER_PREFIX + uid, redisKey);
    }

    /**
     * @param session user session
     * @return user token
     */
    public static UserToken from(Session session) {
        if (session == null || session.getId(false) == null) {
            return null;
        }
        String redisKey = Session.REDIS_PREFIX + session.getId(false);
        Object obj = session.get(UserToken.NAME);
        if (obj instanceof String) {
            UserToken userToken = UserToken.from((String) obj);
            if (userToken == null) {
                return null;
            }
            Boolean exists = Application.getRedisTemplate().opsForSet().isMember(REDIS_USER_PREFIX + userToken.getId(), redisKey);
            if (exists == null || !exists) {
                session.destroy();
                return null;
            }
            return userToken;
        }
        return null;
    }

    /**
     * get toke by token, for api
     *
     * @param json String
     * @return user token
     */
    @SuppressWarnings("EmptyCatchBlock")
    public static UserToken from(String json) {
        ObjectMapper mapper = new ObjectMapper();
        try {
            var userToken = mapper.readValue(json, UserToken.class);
            if (userToken != null && userToken.isEffective()) {
                return userToken;
            }
        } catch (JsonProcessingException e) {
            int i = 0;
        }
        return null;
    }


    /**
     * save token, for http request
     *
     * @param session http session
     */
    public void save(Session session) {
        String redisKey = Session.REDIS_PREFIX + session.getId(true);
        session.set(UserToken.NAME, toString());
        Application.getRedisTemplate().opsForSet().add(REDIS_USER_PREFIX + getId(), redisKey);
        updateRedis(redisKey);
    }

    /**
     * save and get token, for api
     *
     * @return token
     */
    public String saveAndGetToken() {
        return null;
    }

    /**
     * update redis data
     */
    @SuppressWarnings("EmptyCatchBlock")
    private void updateRedis(String excludeRedisKey) {
        Set<String> set = Application.getRedisTemplate().opsForSet().members(REDIS_USER_PREFIX + getId());
        if (set == null) {
            return;
        }

        set.forEach(redisKey -> {
            if (redisKey.equals(excludeRedisKey)) {
                return;
            }
            UserToken userToken = null;
            RedisConnection redisConnection = Objects.requireNonNull(Application.getRedisTemplate().getConnectionFactory()).getConnection();
            try {

                byte[] objectData = redisConnection.hGet(redisKey.getBytes(), (UserToken.NAME).getBytes());
                assert objectData != null;
                ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(objectData);
                ObjectInputStream objectInputStream = new ObjectInputStream(byteArrayInputStream);
                userToken = UserToken.from((String) objectInputStream.readObject());
            } catch (Exception e) {
            }
            if (userToken == null) {
                deleteToken(getId(), redisKey);
                return;
            }
            if (userToken.getId().equals(getId())
                    && userToken.getName().equals(getName())
                    && userToken.getPassword().equals(getPassword())
                    && userToken.getSalt().equals(getSalt())
            ) {
                if (!userToken.getAvatar().equals(getAvatar())
                        || !userToken.getPhone().equals(getPhone())
                        || userToken.getLevel() != getLevel()) {
                    userToken.setAvatar(getAvatar());
                    userToken.setLevel(getLevel());
                    userToken.setPhone(getPhone());
                    redisConnection.hSet(redisKey.getBytes(), (UserToken.NAME).getBytes(), SerializationHelper.serialize(userToken.toString()));
                }
            } else {
                deleteToken(getId(), redisKey);
            }

        });
    }

    @Override
    public String toString() {
        ObjectMapper mapper = new ObjectMapper();
        String json = null;

        try {
            json = mapper.writeValueAsString(this);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return json;
    }
}
