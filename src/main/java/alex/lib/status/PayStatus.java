package alex.lib.status;

import java.util.HashMap;

/**
 * 支付状态
 */
public class PayStatus {
    static final HashMap<Long, String> STATUS;

    static {
        STATUS = new HashMap<>();
        STATUS.put(0L, "待付款");
        STATUS.put(1L, "已付款");
        STATUS.put(2L, "已退款");
    }
    public static String getStatus(long code) {
        return STATUS.get(code);
    }
}
