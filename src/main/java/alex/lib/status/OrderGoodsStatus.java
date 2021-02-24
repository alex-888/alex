package alex.lib.status;

import java.util.HashMap;

/**
 * 订单中的商品状态
 */
public class OrderGoodsStatus {
    static final HashMap<Long, String> STATUS;

    static {
        STATUS = new HashMap<>();
        STATUS.put(0L, "未发货");
        STATUS.put(1L, "已发货");
        STATUS.put(2L, "已收货");
        STATUS.put(3L, "已退款");
    }
    public static String getStatus(long code) {
        return STATUS.get(code);
    }
}
