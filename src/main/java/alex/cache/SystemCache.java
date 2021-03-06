package alex.cache;

import alex.lib.Crypto;
import alex.lib.Helper;
import alex.repository.SystemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.DependsOn;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.List;

@Component
@DependsOn("Crypto")
public class SystemCache {
    //备案号
    private static String beian;

    // 首页轮播
    private static String carousel;

    //静态文件路径
    private static String jsPath;
    //静态文件版本号
    private static String jsVersion;
    private static List<String> keywords;
    private static String keywordsStr;
    private static long maxBuyNum;

    //site name
    private static String name;
    private static String storageType;
    private static String ossAk;
    private static String ossAks;
    private static String ossBucket;
    private static String ossBucketUrl;
    private static String ossEndpoint;
    private static String themePc;
    private static String themeMobile;
    //site url
    private static String url;
    private static SystemRepository systemRepository;

    @PostConstruct
    public synchronized static void init() {
        List<String> keywords1 = new ArrayList<>();
        systemRepository.findAll().forEach(entity -> {
            if (entity.getEntity().equals("sys")) {
                switch (entity.getAttribute()) {
                    case "beian":
                        beian = entity.getValue();
                        break;
                    case "carousel":
                        setCarousel(entity.getValue());
                        break;
                    case "jsPath":
                        jsPath = entity.getValue();
                        break;
                    case "jsVersion":
                        jsVersion = entity.getValue();
                        break;
                    case "keywords":
                        keywordsStr = entity.getValue();
                        for (var str : keywordsStr.split(",")) {
                            str = str.trim();
                            if (str.length() > 0) {
                                keywords1.add(str);
                            }
                        }
                        keywords = keywords1;
                        break;
                    case "maxBuyNum":
                        maxBuyNum = Helper.longValue(entity.getValue());
                        break;
                    case "name":
                        name = entity.getValue();
                        break;
                    case "url":
                        url = entity.getValue();
                        break;
                }
                return;
            }
            if (entity.getEntity().equals("storage")) {
                switch (entity.getAttribute()) {
                    case "type":
                        storageType = entity.getValue();
                        break;
                    case "ossAk":
                        ossAk = Crypto.decrypt(entity.getValue());
                        break;
                    case "ossAks":
                        ossAks = Crypto.decrypt(entity.getValue());
                        break;
                    case "ossBucket":
                        ossBucket = entity.getValue();
                        break;
                    case "ossBucketUrl":
                        ossBucketUrl = entity.getValue();
                        break;
                    case "ossEndpoint":
                        ossEndpoint = entity.getValue();
                        break;
                }
                return;
            }
            if (entity.getEntity().equals("theme")) {
                switch (entity.getAttribute()) {
                    case "mobile":
                        themeMobile = entity.getValue();
                        break;
                    case "pc":
                        themePc = entity.getValue();
                        break;
                }
            }
        });
    }

    /**
     * 获取备案号
     *
     * @return 备案号
     */
    public static String getBeian() {
        return beian;
    }

    /**
     * 获取首页轮播JSON
     *
     * @return json string
     */
    public static String getCarousel() {
        return carousel;
    }

    /**
     * 更新首页轮播JSON
     *
     * @param carousel 首页轮播JSON
     */
    public static void setCarousel(String carousel) {
        if (carousel.length() < 2) {
            carousel = "[]";
        }
        SystemCache.carousel = carousel;
    }

    public static String getJsPath() {
        return jsPath;
    }

    public static String getJsVersion() {
        return jsVersion;
    }

    public static void setJsVersion(String jsVersion) {
        SystemCache.jsVersion = jsVersion;
    }

    public static List<String> getKeywords() {
        return keywords;
    }

    public static String getKeywordsStr() {
        return keywordsStr;
    }

    public static long getMaxBuyNum() {
        return maxBuyNum;
    }

    public static String getOssAk() {
        return ossAk;
    }

    public static String getOssAks() {
        return ossAks;
    }

    public static String getOssBucket() {
        return ossBucket;
    }

    public static String getOssBucketUrl() {
        return ossBucketUrl;
    }

    public static String getOssEndpoint() {
        return ossEndpoint;
    }

    public static String getStorageType() {
        return storageType;
    }

    public static String getThemeMobile() {
        return themeMobile;
    }

    public static String getThemePc() {
        return themePc;
    }

    public static String getName() {
        return name;
    }

    public static String getUrl() {
        return url;
    }

    @Autowired
    private void autowire(SystemRepository systemRepository) {
        SystemCache.systemRepository = systemRepository;
    }
}
