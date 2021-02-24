package alex.lib.status;

import java.util.HashMap;

/**
 * 订单状态
 */
public class OrderStatus {
    static final HashMap<Long, String> STATUS;

    static {
        STATUS = new HashMap<>();
        STATUS.put(0L, "待付款");
        STATUS.put(1L, "已付款,待发货");
        STATUS.put(2L, "已发货");
        STATUS.put(3L, "已确认收货");
        STATUS.put(10L, "已取消");
        STATUS.put(20L, "已退货");
        STATUS.put(21L, "已退货(部分退货)");
    }
    public static String getStatus(long code) {
        return STATUS.get(code);
    }
}
