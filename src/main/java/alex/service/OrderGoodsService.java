package alex.service;

import alex.Application;
import alex.entity.OrderGoodsEntity;
import org.springframework.stereotype.Service;

@Service
public class OrderGoodsService {
    /**
     * 数据库插入订单商品记录
     *
     * @param ety orderGoodsEntity
     */
    public void insertOrderGoods(OrderGoodsEntity ety) {
        var sql = "INSERT INTO alex.orderGoods (orderId, goodsId, specId, specDes, goodsName, price, weight, num, status, img)" +
                " VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0, ?)";
        Application.getJdbcTemplate().update(sql, ety.getOrderId(), ety.getGoodsId(), ety.getSpecId(),
                ety.getSpecDes(), ety.getGoodsName(), ety.getPrice(), ety.getWeight(), ety.getNum(), ety.getImg());
    }
}
