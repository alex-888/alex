package alex.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(
        prefix = "app"
)
public class AppProperties {
    private String key;

    /**
     * Secret Key
     * @return key
     */
    public String getKey() {
        return key;
    }

    /**
     * 密钥，用于加/解密数据,请勿随意更改
     * @param key key
     */
    public void setKey(String key) {
        this.key = key;
    }
}
