package alex.cache;

import alex.config.AppConfig;
import alex.lib.Helper;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Component("GoodsCache")
public class GoodsCache {
    /* 推荐商品,long:类别ID, Map<String, Object>  */
    private static List<Map<String, Object>> recommend;

    @PostConstruct
    public static synchronized void init() {
        updateRecommend();
    }

    /**
     * 获取推荐商品
     *
     * @return 推荐商品
     */
    public static List<Map<String, Object>> getRecommend() {
        return recommend;
    }

    /**
     * 更新推荐商品
     */
    public synchronized static void updateRecommend() {
        List<Map<String, Object>> recommend1 = new LinkedList<>();
        AppConfig.getJdbcTemplate().queryForList("select id,name from category where parentId = 0")
                .forEach(m -> {
                    Map<String, Object> map = new HashMap<>();
                    long cateId = Helper.longValue(m.get("id"));

                    // 子类别
                    StringBuilder catIds = new StringBuilder(Long.toString(cateId));
                    for (var v : CategoryCache.getChildren(cateId)) {
                        catIds.append(",").append(v.getId());
                    }

                    var sql = String.format("select id,imgs,name,price from goods where cateId in (%s) and status & 0b10 > 0 order by recommend desc, updateAt desc limit 16", catIds);
                    List<Map<String, Object>> goodsList = new LinkedList<>();
                    AppConfig.getJdbcTemplate().queryForList(sql).forEach(m1 -> {
                        Map<String, Object> goodsMap = new HashMap<>();
                        goodsMap.put("id", m1.get("id"));
                        goodsMap.put("img", ((String) m1.get("imgs")).split(",")[0]);
                        goodsMap.put("name", m1.get("name"));
                        goodsMap.put("price", m1.get("price"));
                        goodsList.add(goodsMap);
                    });

                    sql = "select id,name from category where parentId = ? order by recommend limit 16";
                    List<Map<String, Object>> cateList = new LinkedList<>(AppConfig.getJdbcTemplate().queryForList(sql, cateId));
                    map.put("id", cateId);
                    map.put("name", m.get("name"));
                    map.put("cateList", cateList);
                    map.put("goodsList", goodsList);
                    recommend1.add(map);
                });
        recommend = recommend1;
    }

}
