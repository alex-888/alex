package alex.cache;

import alex.Application;
import alex.entity.GoodsEntity;
import alex.repository.GoodsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Component("GoodsCache")
public class GoodsCache {

    /* 推荐商品,long:类别ID, List<Long>:推荐商品ID */
    private static Map<Long, List<Long>> recommend = new ConcurrentHashMap<>();
    private static Map<Long, GoodsEntity> rows;
    private static GoodsRepository goodsRepository;
    public static Map<Long, GoodsEntity> getRows() {
        return rows;
    }

    @PostConstruct
    public static synchronized void init() {
        Map<Long, GoodsEntity> map = new ConcurrentHashMap<>();
        goodsRepository.findAll().forEach(goodsEntity -> {
            map.put(goodsEntity.getId(), goodsEntity);
        });
        rows = map;
    }

    @Autowired
    private void setGoodsRepository(GoodsRepository goodsRepository) {
        GoodsCache.goodsRepository = goodsRepository;
    }

    /**
     * 根据类别ID获取推荐商品
     *
     * @param cateId 商品类别ID,只能是一级类别
     * @return 推荐商品
     */
    public static List<GoodsEntity> getRecommendByCateId(long cateId) {
        return null;
    }

    /**
     * 更新推荐商品ID
     *
     * @param cateId 商品类别ID,只能是一级类别
     */
    @SuppressWarnings("ConstantConditions")
    public synchronized static void updateRecommendByCateId(long cateId) {
        String sql = "select count(*) from category where parentId = 0 and id = ?";
        if (Application.getJdbcTemplate().queryForObject(sql, Long.class, cateId) == 0) {
            return;
        }
    }


}
