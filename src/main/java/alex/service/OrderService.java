package alex.service;

import alex.config.AppConfig;
import alex.entity.*;
import alex.lib.Cart;
import alex.lib.GoodsStatus;
import alex.lib.Helper;
import alex.repository.*;
import org.springframework.dao.CannotAcquireLockException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.util.*;

@Service
public class OrderService {

    @Resource
    GoodsRepository goodsRepository;

    @Resource
    GoodsSpecRepository goodsSpecRepository;

    @Resource
    OrderRepository orderRepository;

    @Resource
    OrderGoodsService orderGoodsService;

    @Resource
    UserAddressRepository userAddressRepository;

    @Resource
    UserRepository userRepository;

    public  String cancelOrder(long orderNo) {

        return cancelOrder(orderRepository.findByNo(orderNo));
    }

    public String cancelOrder(OrderEntity order) {

        if (order == null) {
            return "订单不存在";
        }
        if (order.getStatus() != 0L) {}
        return null;
    }
    /**
     * 根据订单ID生成订单号
     *
     * @param orderId 订单ID
     * @return 订单号
     */
    public static long generalOrderNo(long orderId) {
        String str = Helper.dateFormat(new Date(), "yyMMdd");
        String str1 = String.format("%06d", orderId * 997 % 1000000);
        return Helper.longValue(str + str1);
    }

    /**
     * 数据库插入订单
     *
     * @param ety orderEntity
     */
    public void insertOrder(OrderEntity ety) {
        String sql = "insert into orders (createTime, id, no, userId, region, consignee, phone, price, shippingFee,payType,source)"
                + "values (NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        AppConfig.getJdbcTemplate().update(sql, ety.getId(), ety.getNo(), ety.getUserId(), ety.getRegion(),
                ety.getConsignee(), ety.getPhone(), ety.getPrice(), ety.getShippingFee(), ety.getPayType(),
                ety.getSource());
    }

    /**
     * 下单
     *
     * @param addrId      地址ID
     * @param cart        用户购物车
     * @param sumPrice    商品金额,用于效验
     * @param shippingFee 物流费,用于效验
     * @return 订单信息
     */
    @Transactional
    public OrderInfo addOrder(long addrId, Cart cart, long sumPrice, long shippingFee) {
        OrderInfo orderInfo = new OrderInfo();
        long userId = cart.getUserToken().getId();
        UserAddressEntity addr = userAddressRepository.findByIdAndUserId(addrId, userId);
        if (addr == null) {
            return orderInfo.setErr("收货地址不存在");
        }
        if (cart.sumPrice() != sumPrice || cart.shippingFee(addr.getRegion()) != shippingFee || cart.sumNum() == 0) {
            return orderInfo.setErr("购物车被修改，请重新提交");
        }
        UserEntity userEntity = userRepository.findByIdForUpdate(userId);
        //要购买的商品,完成后从购物车清除
        Set<Cart.Item> cartItems = new LinkedHashSet<>();
        for (var item : cart.getItems()) {
            if (!item.isSelected()) {
                continue;
            }
            cartItems.add(item);
        }
        // 优化锁行顺序, 按商品ID排序后顺序锁行
        List<Long> goodsIds = new ArrayList<>();
        for (var item : cartItems) {
            goodsIds.add(item.getGoodsId());
        }
        Collections.sort(goodsIds);
        Map<Long, GoodsEntity> goodsEntityMap = new HashMap<>();
        for (var goodsId : goodsIds) {
            try {
                goodsEntityMap.put(goodsId, goodsRepository.findByIdForUpdate(goodsId));
            } catch (CannotAcquireLockException e) {
                TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                return orderInfo.setErr("系统繁忙");
            }
        }

        for (var item : cartItems) {
            GoodsEntity goodsEntity = goodsEntityMap.get(item.getGoodsId());
            if (goodsEntity == null
                    || (goodsEntity.getStatus() & GoodsStatus.RECYCLE_BIN) > 0
                    || (goodsEntity.getStatus() & GoodsStatus.ON_SELL) == 0
            ) {
                return orderInfo.setErr("商品已下架");
            }
            // 库存
            if (item.getSpecId() == 0) {
                if (goodsEntity.getStock() < item.getNum()) {
                    return orderInfo.setErr("库存不足:" + goodsEntity.getName());
                }
            } else {
                GoodsSpecEntity goodsSpecEntity = null;
                try {
                    goodsSpecEntity = goodsSpecRepository.findByIdForUpdate(item.getSpecId());
                } catch (CannotAcquireLockException e) {
                    TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    return orderInfo.setErr("系统繁忙");
                }
                if (goodsSpecEntity == null || goodsSpecEntity.getGoodsId() != item.getGoodsId()) {
                    return orderInfo.setErr("规格数据错误:" + goodsEntity.getName());
                }
                if (goodsSpecEntity.getStock() < item.getNum()) {
                    return orderInfo.setErr("库存不足:" + goodsEntity.getName());
                }
            }
        }
        // 创建订单信息
        OrderEntity orderEntity = new OrderEntity();
        orderEntity.setId(AppConfig.getOrderId().incrementAndGet());
        orderEntity.setNo(generalOrderNo(orderEntity.getId()));
        orderEntity.setUserId(userId);
        orderEntity.setRegion(addr.getRegion());
        orderEntity.setConsignee(addr.getConsignee());
        orderEntity.setPhone(addr.getPhone());
        orderEntity.setPrice(sumPrice + shippingFee);
        orderEntity.setShippingFee(shippingFee);

        // 扣库存，创建订单商品
        cartItems.forEach(item -> {
            if (item.getSpecId() == 0) {
                AppConfig.getJdbcTemplate().update(
                        "update goods set stock=stock - ? where id = ?",
                        item.getNum(), item.getGoodsId());
            } else {
                AppConfig.getJdbcTemplate().update(
                        "update goodsSpec set stock=stock - ? where id = ?",
                        item.getNum(), item.getSpecId());
            }
            OrderGoodsEntity orderGoodsEntity = new OrderGoodsEntity();
            orderGoodsEntity.setOrderId(orderEntity.getId());
            orderGoodsEntity.setGoodsId(item.getGoodsId());
            orderGoodsEntity.setGoodsName(item.getGoodsName());
            orderGoodsEntity.setNum(item.getNum());
            orderGoodsEntity.setSpecId(item.getSpecId());
            orderGoodsEntity.setSpecDes(item.getSpecDes());
            orderGoodsEntity.setPrice(item.getGoodsPrice());
            orderGoodsEntity.setWeight(item.getGoodsWeight());
            orderGoodsEntity.setImg(item.getGoodsImg());
            orderGoodsService.insertOrderGoods(orderGoodsEntity);
        });
        insertOrder(orderEntity);
        cart.del(cartItems);
        orderInfo.setOrderNo(orderEntity.getNo());
        return orderInfo;

    }

    public static class OrderInfo {
        private String err;
        private long orderNo;

        public String getErr() {
            return err;
        }

        public OrderInfo setErr(String err) {
            this.err = err;
            return this;
        }

        public long getOrderNo() {
            return orderNo;
        }

        public void setOrderNo(long orderNo) {
            this.orderNo = orderNo;
        }
    }
}
