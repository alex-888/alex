package alex.repository;

import alex.entity.OrderEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository extends JpaRepository<OrderEntity, Long> {
    /**
     * 根据订单号返回订单
     * @param no 订单号
     * @return 订单entity
     */
    OrderEntity findByNo(long no);
    List<OrderEntity> findByUserId(long userid);

}
