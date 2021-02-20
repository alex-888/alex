package alex.service;

import alex.config.AppConfig;
import alex.entity.UserAddressEntity;
import alex.repository.UserAddressRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;

@Service
public class UserAddressService {

    private final long maxAddress = 10;

    @Resource
    UserAddressRepository userAddressRepository;

    @Transactional
    public String addAddress(UserAddressEntity entity) {
        if (userAddressRepository.countByUserId(entity.getUserId()) >= maxAddress) {
            return "新增地址失败，现有地址已达到上限(" + maxAddress + "条)";
        }
        String sql = "insert into userAddress (userId, consignee,phone,region,address,dft) values (?,?,?,?,?,?)";
        AppConfig.getJdbcTemplate().update(sql,
                entity.getUserId(), entity.getConsignee(), entity.getPhone(),
                entity.getRegion(), entity.getAddress(), entity.getDft());
        entity.setId(AppConfig.getJdbcTemplate().queryForObject("select last_insert_id()", Long.class));
        if(entity.getDft() > 0) {
            AppConfig.getJdbcTemplate().update("update userAddress set dft=0 where userId=? and id != ?",
                    entity.getUserId(), entity.getId());
        }
        return null;
    }

    @Transactional
    public void setDefault(UserAddressEntity entity) {
        AppConfig.getJdbcTemplate().update("update userAddress set dft=1 where id=?", entity.getId());
        AppConfig.getJdbcTemplate().update("update userAddress set dft=0 where userId=? and id != ?",
                entity.getUserId(), entity.getId());
    }

    @Transactional
    public void updateAddress(UserAddressEntity entity) {
        String sql = "update userAddress set userId=?,consignee=?,phone=?,region=?,address=?,dft=? where id=?";
        AppConfig.getJdbcTemplate().update(sql,
                entity.getUserId(), entity.getConsignee(), entity.getPhone(),
                entity.getRegion(), entity.getAddress(), entity.getDft(), entity.getId());
        if(entity.getDft() > 0) {
            AppConfig.getJdbcTemplate().update("update userAddress set dft=0 where userId=? and id != ?",
                    entity.getUserId(), entity.getId());
        }
    }
}
