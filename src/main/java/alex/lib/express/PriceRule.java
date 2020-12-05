package alex.lib.express;

import java.util.ArrayList;
import java.util.List;

/**
 * 快递价格规则
 */
public class PriceRule {

    // 首重重量g
    private long firstWeight;
    // 首重价格
    private long firstPrice;
    // 续重重量
    private long additionalWeight;
    // 续重价格
    private long additionalPrice;
    private final List<ProvincePrice> provincePrices = new ArrayList<>();

    // 其他地区默认运费
    private boolean otherDefault = true;

    public PriceRule() {
    }

    public boolean isOtherDefault() {
        return otherDefault;
    }

    public void setOtherDefault(boolean otherDefault) {
        this.otherDefault = otherDefault;
    }

    public long getFirstPrice() {
        return firstPrice;
    }

    public void setFirstPrice(long firstPrice) {
        this.firstPrice = firstPrice;
    }

    public long getFirstWeight() {
        return firstWeight;
    }

    public void setFirstWeight(long firstWeight) {
        this.firstWeight = firstWeight;
    }

    public long getAdditionalPrice() {
        return additionalPrice;
    }

    public void setAdditionalPrice(long additionalPrice) {
        this.additionalPrice = additionalPrice;
    }

    public long getAdditionalWeight() {
        return additionalWeight;
    }

    public void setAdditionalWeight(long additionalWeight) {
        this.additionalWeight = additionalWeight;
    }

    public List<ProvincePrice> getProvincePrices() {
        return provincePrices;
    }

    /**
     * 计算物流费用
     *
     * @param code   收货地区代码
     * @param weight 重量g
     * @return 所需费用, 负数不支持该地区派送
     */
    public long getShippingFee(long code, long weight) {
        long price1 = 0, price2 = 0;
        // 查找目标区域首重、续重价格
        for (var rule : provincePrices) {
            if (rule.getProvinces().contains(code)) {
                price1 = rule.getFirstPrice();
                price2 = rule.getAdditionalPrice();
                break;
            }
        }
        if (price1 <= 0 || price2 <= 0) {
            if (otherDefault) {
                price1 = firstPrice;
                price2 = additionalPrice;
            } else {
                return -1;
            }
        }

        //计算返回运费
        if (weight <= firstWeight) {
            return price1;
        }
        weight -= firstWeight;
        long num = weight / additionalWeight;
        if (weight % additionalWeight > 0) {
            num++;
        }
        return price1 + price2 * num;
    }
}
