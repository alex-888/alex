package alex.service;

import alex.Application;
import alex.entity.GoodsEntity;
import alex.entity.OrderEntity;
import alex.entity.UserAddressEntity;
import alex.entity.UserEntity;
import alex.lib.Cart;
import alex.lib.GoodsStatus;
import alex.lib.Helper;
import alex.repository.GoodsRepository;
import alex.repository.OrderRepository;
import alex.repository.UserAddressRepository;
import alex.repository.UserRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.transaction.Transactional;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

@Service
public class OrderService {

    @Resource
    GoodsRepository goodsRepository;

    @Resource
    private OrderRepository orderRepository;

    @Resource
    UserAddressRepository userAddressRepository;

    @Resource
    UserRepository userRepository;

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
        //购买的商品,完成后从购物车清除
        Set<Cart.Item> cartItems = new HashSet<>();
        for (var item : cart.getItems()) {
            if (!item.isSelected()) {
                continue;
            }
            cartItems.add(item);
            GoodsEntity goodsEntity = goodsRepository.findByIdForUpdate(item.getGoodsId());
            if ((goodsEntity.getStatus() & GoodsStatus.RECYCLE_BIN) > 0
                    || (goodsEntity.getStatus() & GoodsStatus.ON_SELL) == 0
            ) {
                return orderInfo.setErr("商品已下架");
            }
        }
        OrderEntity orderEntity = new OrderEntity();
        orderEntity.setId(Application.ORDER_ID.incrementAndGet());
        orderEntity.setNo(generalOrderNo(orderEntity.getId()));
        orderEntity.setUserId(userId);
        orderEntity.setRegion(addr.getRegion());
        orderEntity.setPrice(sumPrice);
        orderEntity.setShippingFee(shippingFee);
        insertOrder(orderEntity);
        cart.del(cartItems);
        orderInfo.setOrderNo(orderEntity.getNo());
        return orderInfo;

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
     * @param orderEntity orderEntity
     * @return orderId
     */
    public static boolean insertOrder(OrderEntity orderEntity) {
        String sql = "insert into orders (createTime, id, no, userId, region, price, shippingFee,payType,source)"
                + "values (NOW(), ?, ?, ?, ?, ?, ?, ?, ?)";
        if (Application.JDBC_TEMPLATE.update(sql, orderEntity.getId(), orderEntity.getNo(),
                orderEntity.getUserId(), orderEntity.getRegion(), orderEntity.getPrice(),
                orderEntity.getShippingFee(), orderEntity.getPayType(), orderEntity.getSource()) == 0) {
            return false;
        }
        return true;
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
