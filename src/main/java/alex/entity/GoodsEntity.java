package alex.entity;

import org.springframework.jdbc.core.RowMapper;

import javax.persistence.*;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

@Entity
@Table(name = "goods")
public class GoodsEntity implements RowMapper<GoodsEntity> {
    private long id;
    private long brandId;
    private long cateId;
    private Timestamp createAt;
    private Timestamp updateAt;
    private String name;
    private String des;
    private String imgs;
    private long price;
    private long stock;
    private long weight;
    private long recommend = 1000;
    private Date released = new Date(System.currentTimeMillis());
    private String spec;
    private long status;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public long getBrandId() {
        return brandId;
    }

    public void setBrandId(long brandId) {
        this.brandId = brandId;
    }

    public long getCateId() {
        return cateId;
    }

    public void setCateId(long cateId) {
        this.cateId = cateId;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(columnDefinition = "text")
    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    @Column(columnDefinition = "text")
    public String getImgs() {
        return imgs;
    }

    public void setImgs(String imgs) {
        this.imgs = imgs;
    }

    public long getPrice() {
        return price;
    }

    public void setPrice(long price) {
        this.price = price;
    }

    public long getStock() {
        return stock;
    }

    public void setStock(long stock) {
        this.stock = stock;
    }

    public long getWeight() {
        return weight;
    }

    public void setWeight(long weight) {
        this.weight = weight;
    }

    public long getRecommend() {
        return recommend;
    }

    public void setRecommend(long recommend) {
        this.recommend = recommend;
    }

    public Date getReleased() {
        return released;
    }

    public void setReleased(Date release) {
        this.released = release;
    }

    @Column(columnDefinition = "text")
    public String getSpec() {
        return spec;
    }

    public void setSpec(String spec) {
        this.spec = spec;
    }

    public long getStatus() {
        return status;
    }

    public void setStatus(long status) {
        this.status = status;
    }

    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }


    @Override
    public GoodsEntity mapRow(ResultSet rs, int rowNum) throws SQLException {
        GoodsEntity entity = new GoodsEntity();
        entity.setId(rs.getLong("id"));
        entity.setBrandId(rs.getLong("brandId"));
        entity.setCateId(rs.getLong("cateId"));
        entity.setCreateAt(rs.getTimestamp("createAt"));
        entity.setDes(rs.getString("des"));
        entity.setImgs(rs.getString("imgs"));
        entity.setName(rs.getString("name"));
        entity.setPrice(rs.getLong("price"));
        entity.setRecommend(rs.getLong("recommend"));
        entity.setReleased(rs.getDate("released"));
        entity.setSpec(rs.getString("spec"));
        entity.setStatus(rs.getLong("status"));
        entity.setStock(rs.getLong("stock"));
        entity.setUpdateAt(rs.getTimestamp("updateAt"));
        entity.setWeight(rs.getLong("weight"));
        return entity;
    }
}
