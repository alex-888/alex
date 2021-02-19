package alex.controller.admin.sys;

import alex.Application;
import alex.cache.SystemCache;
import alex.config.AppConfig;
import alex.lib.AdminHelper;
import alex.lib.Crypto;
import alex.lib.Helper;
import alex.lib.JsonResult;
import alex.repository.SystemRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller(value = "admin/sys/manage")
@RequestMapping(path = "/admin/sys/manage")
public class Manage {
    @Resource
    SystemRepository systemRepository;

    @GetMapping(value = "")
    public ModelAndView getIndex(HttpServletRequest request) {
        ModelAndView modelAndView = Helper.newModelAndView("admin/sys/manage/index", request);

        modelAndView.addObject("beian", SystemCache.getBeian());
        modelAndView.addObject("jsPath", SystemCache.getJsPath());
        modelAndView.addObject("keywords", SystemCache.getKeywordsStr());
        modelAndView.addObject("maxBuyNum", SystemCache.getMaxBuyNum());
        modelAndView.addObject("siteName", SystemCache.getName());
        modelAndView.addObject("siteUrl", SystemCache.getUrl());
        modelAndView.addObject("storageType", SystemCache.getStorageType());
        modelAndView.addObject("ossAk", SystemCache.getOssAk());
        modelAndView.addObject("ossAks", SystemCache.getOssAks());
        modelAndView.addObject("ossBucket", SystemCache.getOssBucket());
        modelAndView.addObject("ossBucketUrl", SystemCache.getOssBucketUrl());
        modelAndView.addObject("ossEndpoint", SystemCache.getOssEndpoint());
        modelAndView.addObject("themeMobile", SystemCache.getThemeMobile());
        modelAndView.addObject("themePc", SystemCache.getThemePc());
        modelAndView.addObject("title", "系统管理");
        return modelAndView;
    }

    @PostMapping(value = "", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String postIndex(HttpServletRequest request) {
        JsonResult jsonResult = new JsonResult();
        Map<String, String> map = new HashMap<>();
        map.put("beian", request.getParameter("beian"));
        map.put("jsPath", request.getParameter("jsPath"));
        map.put("keywords", request.getParameter("keywords"));
        map.put("maxBuyNum", request.getParameter("maxBuyNum"));
        map.put("siteName", request.getParameter("siteName"));
        map.put("siteUrl", request.getParameter("siteUrl"));
        map.put("storageType", request.getParameter("storageType"));
        map.put("ossAk", request.getParameter("ossAk"));
        map.put("ossAks", request.getParameter("ossAks"));
        map.put("ossBucket", request.getParameter("ossBucket"));
        map.put("ossBucketUrl", request.getParameter("ossBucketUrl"));
        map.put("ossEndpoint", request.getParameter("ossEndpoint"));
        map.put("themeMobile", request.getParameter("themeMobile"));
        map.put("themePc", request.getParameter("themePc"));
        map.forEach((k, v) -> {
            if (v == null) {
                map.put(k, "");
            } else {
                map.put(k, v.trim());
            }
        });
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='sys' and attribute='beian'", map.get("beian"));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='sys' and attribute='jsPath'", map.get("jsPath"));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='sys' and attribute='keywords'", map.get("keywords"));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='sys' and attribute='maxBuyNum'", map.get("maxBuyNum"));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='sys' and attribute='name'", map.get("siteName"));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='sys' and attribute='url'", map.get("siteUrl"));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='storage' and attribute='type'", map.get("storageType"));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='storage' and attribute='ossAk'", Crypto.encrypt(map.get("ossAk")));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='storage' and attribute='ossAks'", Crypto.encrypt(map.get("ossAks")));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='storage' and attribute='ossBucket'", map.get("ossBucket"));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='storage' and attribute='ossBucketUrl'", map.get("ossBucketUrl"));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='storage' and attribute='ossEndpoint'", map.get("ossEndpoint"));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='theme' and attribute='mobile'", map.get("themeMobile"));
        AppConfig.getJdbcTemplate().update("update system set value=? where entity='theme' and attribute='pc'", map.get("themePc"));
        SystemCache.init();
        jsonResult.setMsg("保存成功");
        return AdminHelper.msgPage(jsonResult, request);
    }
}
