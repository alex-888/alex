package alex.lib;

import alex.cache.RegionCache;
import alex.cache.SystemCache;
import alex.lib.status.AccountStatus;
import alex.lib.status.OrderGoodsStatus;
import alex.lib.status.OrderStatus;
import alex.lib.status.SexStatus;

/**
 * thymeleaf utils
 * helper functions for thymeleaf
 */
public class HelperUtils {

    /**
     * 获取账号状态信息
     * @param code code
     * @return info
     */
    public static String getAccountStatusInfo(long code){
        return AccountStatus.getStatusInfo(code);
    }
    /**
     * 获取性别信息
     * @param code code
     * @return info
     */
    public static String getSexStatusInfo(long code) {
        return SexStatus.getStatusInfo(code);
    }

    /**
     * 获取订单商品状态信息
     *
     * @param code 订单商品状态码
     * @return 状态信息
     */
    public static String getOrderGoodsStatusInfo(long code) {
        return OrderGoodsStatus.getStatusInfo(code);
    }

    /**
     * 获取订单状态信息
     *
     * @param code 订单状态码
     * @return 状态信息
     */
    public static String getOrderStatusInfo(long code) {
        return OrderStatus.getStatusInfo(code);
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
     * @return css/js file url
     */
    public static String retouch(String path) {
        return SystemCache.getJsPath() + path + "?v=" + SystemCache.getJsVersion();
    }

}
