package alex.lib;

import alex.config.AppConfig;
import alex.entity.UserLogEntity;
import alex.repository.UserLogRepository;

import java.sql.Timestamp;
import java.util.Calendar;

public class Database {
    public static long insertUserLog(long uid, int type, String msg, String ip) {
        UserLogRepository userLogRepository = AppConfig.getContext().getBean(UserLogRepository.class);
        UserLogEntity userLogEntity = new UserLogEntity();
        userLogEntity.setUid(uid);
        userLogEntity.setType(type);
        userLogEntity.setMsg(msg);
        userLogEntity.setIp(ip);
        userLogEntity.setTime(new Timestamp(Calendar.getInstance().getTimeInMillis()));
        userLogRepository.save(userLogEntity);
        return userLogEntity.getId();
    }
}
