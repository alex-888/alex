package alex.repository;

import alex.entity.OrderGoodsEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderGoodsRepository extends JpaRepository<OrderGoodsEntity, Long> {
}
