package alex.repository;

import alex.entity.GoodsEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface GoodsRepository extends JpaRepository<GoodsEntity, Long> {
    @Query(value = "select * from goods where id = ? for update", nativeQuery = true)
    GoodsEntity findByIdForUpdate(long id);

    long countByCateId(long cateId);
}
