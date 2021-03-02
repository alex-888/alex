package alex.controller.admin.other;

import alex.cache.SystemCache;
import alex.config.AppConfig;
import alex.lib.Helper;
import alex.lib.JsonResult;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Controller(value = "admin/other/home")
@RequestMapping(path = "/admin/other/home")
public class Home {
    /**
     * 首页轮播设置
     * @param request request
     * @return view
     */
    @GetMapping(value = "carousel")
    public ModelAndView getCarousel(HttpServletRequest request) {
        ModelAndView modelAndView = Helper.newModelAndView("admin/other/home/carousel", request);
        modelAndView.addObject("carousel", SystemCache.getCarousel());
        modelAndView.addObject("title", "首页轮播");
        return modelAndView;
    }

    /**
     * 保存首页轮播
     * @param request request
     * @return json
     */
    @PostMapping(value = "carousel", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody()
    public String postCarousel(HttpServletRequest request) {
        JsonResult jsonResult = new JsonResult();
        String[] imgs = request.getParameterValues("img");
        String[] links = request.getParameterValues("link");
        String[] des = request.getParameterValues("des");
        if (imgs == null || links == null || des == null) {
            return jsonResult.setMsg("参数不得为空").toString();
        }
        if (imgs.length != links.length) {
            return jsonResult.setMsg("参数个数不一至,请联系管理员").toString();
        }
        List<Map<String,String>> list = new LinkedList<>();
        for (int i = 0; i< imgs.length; i++) {
            if (imgs[i].length() < 5) {
                continue;
            }
            Map<String, String> map = new HashMap<>();
            map.put("img", imgs[i]);
            map.put("link", links[i]);
            map.put("des", des[i]);
            list.add(map);
        }
        String json = Helper.getJson(list);
        SystemCache.setCarousel(json);
        AppConfig.getJdbcTemplate().update("UPDATE system SET value=? WHERE entity='sys' AND attribute='carousel'", json);
        return jsonResult.setMsg("保存成功").toString();
    }
}
