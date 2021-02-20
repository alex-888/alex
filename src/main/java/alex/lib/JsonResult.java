package alex.lib;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * result json data
 */
public class JsonResult {
    /**
     * client need refresh captcha
     */
    private boolean captcha = false;
    private String msg;
    private String url;
    public final Map<String, String> data  = new LinkedHashMap<>();
    public final Map<String, String> error = new LinkedHashMap<>();



    public Boolean getCaptcha() {
        return captcha;
    }

    /**
     *
     * @param captcha client need refresh captcha
     */
    public void setCaptcha(boolean captcha) {
        this.captcha = captcha;
    }

    public String getMsg() {
        return msg;
    }

    public JsonResult setMsg(String msg) {
        this.msg = msg;
        return this;
    }

    public String getUrl() {
        return url;
    }

    public JsonResult setUrl(String url) {
        this.url = url;
        return this;
    }

    @Override
    public String toString() {
        Map<String, Object> map = new LinkedHashMap<>();

        if (captcha) {
            map.put("captcha", true);
        }
        map.put("msg", msg);
        map.put("url", url);
        map.put("data", data);
        map.put("error", error);
        try {
            return new ObjectMapper().writeValueAsString(map);
        } catch (JsonProcessingException e) {
            System.out.println(e.toString());
            return "error";
        }
    }
}
