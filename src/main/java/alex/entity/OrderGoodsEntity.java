package alex.entity;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "orderGoods")
public class OrderGoodsEntity {


    private long id;
    private long orderId;
    private long goodsId;
    private long specId;
    private String specDes;
    private String goodsName;
    private long price;
    private long weight;
    private long num;
    private long status;
    private String img;


    @Id
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }


    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }


    public long getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(long goodsId) {
        this.goodsId = goodsId;
    }


    public long getSpecId() {
        return specId;
    }

    public void setSpecId(long specId) {
        this.specId = specId;
    }

    public String getSpecDes() {
        return specDes;
    }

    public void setSpecDes(String specDes) {
        this.specDes = specDes;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }


    public long getPrice() {
        return price;
    }

    public void setPrice(long price) {
        this.price = price;
    }


    public long getWeight() {
        return weight;
    }

    public void setWeight(long weight) {
        this.weight = weight;
    }


    public long getNum() {
        return num;
    }

    public void setNum(long num) {
        this.num = num;
    }


    public long getStatus() {
        return status;
    }

    public void setStatus(long status) {
        this.status = status;
    }


    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

}
