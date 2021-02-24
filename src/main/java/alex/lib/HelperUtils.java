package alex.lib;

import alex.cache.RegionCache;
import alex.cache.SystemCache;
import alex.lib.status.OrderGoodsStatus;

/**
 * thymeleaf utils
 * helper functions for thymeleaf
 */
public class HelperUtils {

    public static String getOrderGoodsStatus(long code) {
        return OrderGoodsStatus.getStatus(code);
    }
    public static Region getRegion(long code) {
        return RegionCache.getRegion(code);
    }

    /**
     * 正方形图片缩放
     *
     * @param url   图片地址
     * @param width 图片宽度
     * @return 缩放后的地址
     */
    public static String imgZoom(String url, long width) {
        //noinspection SuspiciousNameCombination
        return imgZoom(url, width, width);
    }

    /**
     * 图片缩放
     *
     * @param url    image url
     * @param width  zooming width
     * @param height zooming width
     * @return 缩放后的地址
     */
    public static String imgZoom(String url, long width, long height) {
        if (url != null) {
            String url1 = url.toLowerCase();
            if (url.startsWith("http")) {
                /* for aliyun oss */
                url += "?x-oss-process=image/resize,w_" + width;
                if (height > 0) {
                    url += ",h_" + height;
                }
                return url;
            }
            /* for nginx */
            url += "?w=" + width;
            if (height > 0) {
                url += "&h=" + height;
            }
            return url;
        }
        return null;
    }

    public static String priceFormat(long l) {
        return Helper.priceFormat(l);
    }

    /**
     * retouch css/js file path
     *
     * @param path css/js file path
     * @return
     */
    public static String retouch(String path) {
        return SystemCache.getJsPath() + path + "?v=" + SystemCache.getJsVersion();
    }

}
