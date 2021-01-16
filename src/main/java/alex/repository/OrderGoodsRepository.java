package alex.repository;

import alex.entity.OrderGoodsEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderGoodsRepository extends JpaRepository<OrderGoodsEntity, Long> {
    List<OrderGoodsEntity> findAllByOrderId(long orderId);
}
