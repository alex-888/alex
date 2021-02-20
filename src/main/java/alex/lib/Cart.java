package alex.lib;

import alex.authentication.UserToken;
import alex.cache.ExpressCache;
import alex.config.AppConfig;
import alex.config.RedisConfig;
import alex.entity.GoodsSpecEntity;
import alex.lib.session.Session;
import alex.repository.GoodsRepository;
import alex.repository.GoodsSpecRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.http.HttpServletRequest;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class Cart {
    public static String NAME = "cart";
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final HttpServletRequest request;
    private final UserToken userToken;
    private List<Item> items;

    private GoodsRepository goodsRepository;
    private GoodsSpecRepository goodsSpecRepository;

    public Cart(HttpServletRequest request) {
        init();
        this.request = request;
        String json;
        userToken = (UserToken) request.getAttribute(UserToken.NAME);
        if (userToken == null) {
            json = (String) Session.from(request).get(NAME);
        } else {
            json = RedisConfig.getStringRedisTemplate().opsForValue().get(NAME + ":" + userToken.getId());
        }
        if (json == null || json.length() < 10) {
            items = new LinkedList<>();
        } else {
            try {
                items = objectMapper.readValue(json, new TypeReference<>() {
                });
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }
        }
        if (!check()) {
            save();
        }
    }

    private void init() {
        goodsRepository = AppConfig.getContext().getBean(GoodsRepository.class);
        goodsSpecRepository = AppConfig.getContext().getBean(GoodsSpecRepository.class);
    }

    public void add(long goodsId, long specId, long num) {
        if (goodsId <= 0 || specId < 0 || num <= 0) {
            return;
        }
        for (Item item : items) {
            if (item.goodsId == goodsId && item.specId == specId) {
                item.num += num;
                save();
                return;
            }

        }
        var item = new Item(goodsId, specId, num);
        items.add(0, item);
        save();
    }

    /**
     * Check goods availability
     *
     * @return all goods availability
     */
    public boolean check() {
        int size = items.size();

        items.removeIf(item -> {
            var goodsEntity = goodsRepository.findById(item.goodsId).orElse(null);
            if (goodsEntity == null
                    //商品回收站
                    || (goodsEntity.getStatus() & GoodsStatus.RECYCLE_BIN) > 0
                    //已下架商品
                    || (goodsEntity.getStatus() & GoodsStatus.ON_SELL) == 0) {
                return true;
            }
            item.setGoodsImg(goodsEntity.getImgs().split(",")[0]);
            item.setGoodsName(goodsEntity.getName());
            item.setGoodsStatus(goodsEntity.getStatus());
            item.setGoodsWeight(goodsEntity.getWeight());
            item.setGoodsPrice(goodsEntity.getPrice());
            if (item.specId == 0) {
                item.setSpecDes("");
                return false;
            }
            var specEntities = goodsSpecRepository.findByGoodsId(item.getGoodsId());
            if (specEntities == null) {
                return true;
            }
            GoodsSpecEntity specEntity = null;
            for (GoodsSpecEntity entity : specEntities) {
                if (entity.getId() == item.getSpecId()) {
                    specEntity = entity;
                    break;
                }
            }
            if (specEntity == null) {
                return true;
            } else {
                item.setGoodsPrice(specEntity.getPrice());
                item.setGoodsWeight(specEntity.getWeight());
                item.setSpecDes(specEntity.getDes());
                return false;
            }

        });
        return size == items.size();
    }

    /**
     * 清空购物车
     */
    public void clear() {
        items.clear();
        save();
    }

    /**
     * 删除商品
     *
     * @param goodsId 商品ID
     * @param specId  商品规格
     */
    public void del(long goodsId, long specId) {
        if (goodsId <= 0 || specId < 0) {
            return;
        }
        for (int i = 0; i < items.size(); i++) {
            var item = items.get(i);
            if (item.goodsId == goodsId && item.specId == specId) {
                items.remove(i);
                break;
            }
        }
        save();
    }

    /**
     * 批量删除商品
     *
     * @param items 商品
     */
    public void del(Collection<Item> items) {
        items.forEach(item -> this.items.remove(item));
        save();
    }

    public List<Item> getItems() {
        return items;
    }

    public UserToken getUserToken() {
        return userToken;
    }

    /**
     * 保存购物车数据
     */
    void save() {
        check();
        String json;
        List<Map<Object, Object>> list = new LinkedList<>();
        items.forEach(item -> {
            Map<Object, Object> map = Map.of(
                    "goodsId", item.getGoodsId(),
                    "specId", item.getSpecId(),
                    "num", item.getNum(),
                    "selected", item.isSelected()
            );
            list.add(map);
        });
        try {
            json = objectMapper.writeValueAsString(list);
            if (userToken == null) {
                Session.from(request).set(NAME, json);
            } else {
                RedisConfig.getStringRedisTemplate().opsForValue().set(NAME + ":" + userToken.getId(), json);
            }

        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
    }

    /**
     * 设置指定商品选中状态
     *
     * @param goodsId  商品ID
     * @param specId   商品规格
     * @param selected 选中状态
     */
    public void setSelected(long goodsId, long specId, boolean selected) {
        if (goodsId <= 0 || specId < 0) {
            return;
        }
        for (Item item : items) {
            if (item.goodsId == goodsId && item.specId == specId) {
                if (item.isSelected() != selected) {
                    item.setSelected(selected);
                    save();
                }
                return;
            }
        }
    }

    /**
     * 设置所有商品选中状态
     *
     * @param selected 选中状态
     */
    public void setSelectedAll(boolean selected) {
        items.forEach(item -> item.setSelected(selected));
        save();
    }

    /**
     * 计算物流费用
     *
     * @param code 收货地址
     * @return 物流费用, 负数不支持该地区派送
     */
    public long shippingFee(long code) {
        // 是否符合免邮费规则
        var freeRule = ExpressCache.getFreeRule();
        if (freeRule.isEnable() && freeRule.getExclude().contains(code) && sumPrice() >= freeRule.getPrice()) {
            return 0;
        }
        var priceRule = ExpressCache.getPriceRule();
        // 包邮商品产生的物流费用
        long price1 = 0;
        price1 = priceRule.getShippingFee(code, sumWeightShippingFree());

        // 全部商品产生的快递非哟
        long price2 = priceRule.getShippingFee(code, sumWeight());

        if (price1 < 0 || price2 <= 0) {
            return -1;
        }
        if (price1 >= price2) {
            return 0;
        }
        return price2 - price1;
    }

    /**
     * 添加商品
     *
     * @param goodsId 商品ID
     * @param specId  商品规格
     * @param num     商品数量
     */
    public void sub(long goodsId, long specId, long num) {
        if (goodsId <= 0 || specId < 0 || num <= 0) {
            return;
        }
        for (int i = 0; i < items.size(); i++) {
            var item = items.get(i);
            if (item.goodsId == goodsId && item.specId == specId) {
                if (item.num > num) {
                    item.num -= num;
                } else {
                    items.remove(i);
                }
                save();
                return;
            }
        }
    }

    /**
     * 选中商品数量合计
     *
     * @return 选中商品数量合计
     */
    public long sumNum() {
        long l = 0;
        for (var item : items) {
            if (item.isSelected()) {
                l += item.num;
            }
        }
        return l;
    }

    /**
     * 选中商品价格合计
     *
     * @return 选中商品价格合计
     */
    public long sumPrice() {
        long l = 0;
        for (var item : items) {
            if (item.isSelected()) {
                l += item.goodsPrice * item.num;
            }
        }
        return l;
    }

    /**
     * 选中商品重量合计
     *
     * @return 选中商品重量合计
     */
    public long sumWeight() {
        long l = 0;
        for (var item : items) {
            if (item.isSelected()) {
                l += item.goodsWeight * item.num;
            }
        }
        return l;
    }

    /**
     * 选中商品内包邮商品重量合计
     *
     * @return 选中商品内包邮商品重量合计
     */
    public long sumWeightShippingFree() {
        long l = 0;
        for (var item : items) {
            if (item.isSelected() && (item.getGoodsStatus() & GoodsStatus.SHIPPING_FEE) == 0) {
                l += item.goodsWeight * item.num;
            }
        }
        return l;
    }

    public static class Item {
        private long goodsId;

        private String goodsImg;

        private String goodsName;

        private long goodsPrice;

        private long goodsStatus;

        private long goodsWeight;

        private long specId;

        private boolean selected = true;
        private String specDes;
        private long num;

        public Item() {
        }

        public Item(long goodsId, long specId, long num) {
            this.goodsId = goodsId;
            this.specId = specId;
            this.num = num;
        }

        public long getGoodsId() {
            return goodsId;
        }

        public String getGoodsImg() {
            return goodsImg;
        }

        public void setGoodsImg(String goodsImg) {
            this.goodsImg = goodsImg;
        }

        public String getGoodsName() {
            return goodsName;
        }

        public void setGoodsName(String goodsName) {
            this.goodsName = goodsName;
        }

        public long getGoodsPrice() {
            return goodsPrice;
        }

        public void setGoodsPrice(long goodsPrice) {
            this.goodsPrice = goodsPrice;
        }

        public long getGoodsStatus() {
            return goodsStatus;
        }

        public void setGoodsStatus(long goodsStatus) {
            this.goodsStatus = goodsStatus;
        }

        public long getGoodsWeight() {
            return goodsWeight;
        }

        public void setGoodsWeight(long goodsWeight) {
            this.goodsWeight = goodsWeight;
        }

        public boolean isSelected() {
            return selected;
        }

        public void setSelected(boolean selected) {
            this.selected = selected;
        }

        public long getSpecId() {
            return specId;
        }

        public String getSpecDes() {
            return specDes;
        }

        public void setSpecDes(String specDes) {
            this.specDes = specDes;
        }

        public long getNum() {
            return num;
        }

        public void setNum(long num) {
            this.num = num;
        }
    }
}
