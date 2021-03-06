package alex.controller;

import alex.cache.CategoryCache;
import alex.cache.GoodsCache;
import alex.cache.RegionCache;
import alex.cache.SystemCache;
import alex.config.AppConfig;
import alex.lib.Captcha;
import alex.lib.Helper;
import alex.lib.Pagination;
import alex.lib.session.Session;
import alex.storage.LocalStorage;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Controller
public class Site {
    /**
     * captcha
     */
    @RequestMapping(value = "captcha")
    @ResponseBody
    public void captcha(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Session session = Session.from(request);
        response.setHeader("Cache-Control", "no-store");
        response.setContentType("image/png");
        OutputStream os = response.getOutputStream();
        var captchaResult = Captcha.getImageCode();
        session.set(Captcha.NAME, captchaResult.getPhrase().toLowerCase());
        try {
            ImageIO.write(captchaResult.getImage(), "png", os);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (os != null) {
                os.flush();
                os.close();
            }
        }
    }


    /**
     * 首页
     * @param request request
     * @return view
     */
    @GetMapping(value = "")
    public ModelAndView getIndex(HttpServletRequest request) {
        ModelAndView modelAndView = Helper.newModelAndView("index", request);
        modelAndView.addObject("carouselJson", SystemCache.getCarousel());
        modelAndView.addObject("recommend", GoodsCache.getRecommend());
        return modelAndView;
    }


    /**
     * 商品列表
     * @param request request
     * @return view
     */
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ModelAndView getList(HttpServletRequest request) {
        StringBuilder sql = new StringBuilder("select id,imgs,name,price from goods where status & 0b10 > 0");
        ModelAndView modelAndView = Helper.newModelAndView("list", request);
        long cid = Helper.longValue(request.getParameter("cid"));
        if (cid > 0 && CategoryCache.getEntityById(cid) != null) {
            sql.append(" and cateId in (").append(cid);
            for (var item : CategoryCache.getChildren(cid)) {
                sql.append(",").append(item.getId());
            }
            sql.append(")");
        } else {
            cid = 0;
        }
        long page = Helper.longValue(request.getParameter("page"));
        String q = request.getParameter("q");
        if (q == null) {
            q = "";
        } else {
            q = Helper.stringRemove(q, "'", "\"", "?", "%", "_", "[", "]").trim();
            StringBuilder qSql = new StringBuilder("'%");
            for (var key : q.split(" ")) {
                if (key.length() > 0) {
                    qSql.append(key).append("%");
                }
            }
            qSql.append("'");
            sql.append(" and name like ").append(qSql);
        }
        sql.append(" order by ");
        String sort = request.getParameter("sort");
        if (sort == null) {
            sort = "";
        }

        switch (sort) {
            case "n":
                sql.append("released desc,recommend desc,id desc");
                break;
            case "p1":
                sql.append("price,recommend desc,released desc,id desc");
                break;
            case "p2":
                sql.append("price desc,recommend desc,released desc,id desc");
                break;
            default:
                sort = "";
                sql.append("recommend desc,released desc,id desc");
        }
        Pagination pagination = new Pagination(sql.toString(), page,
                Map.of("cid", Long.toString(cid), "q", q, "sort", sort));

        String imgs;
        for (var row : pagination.getRows()) {
            imgs = (String) row.get("imgs");
            row.put("img", imgs.split(",")[0]);
        }
        modelAndView.addObject("cid", cid);
        modelAndView.addObject("q", q);
        modelAndView.addObject("sort", sort);
        modelAndView.addObject("categoryPath", CategoryCache.getCategoryPath(cid));
        modelAndView.addObject("pagination", pagination);
        modelAndView.addObject("title", "商品列表");
        return modelAndView;
    }

    @GetMapping(path = "region", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String getRegion() {
        return RegionCache.getRegionJson();
    }

    @RequestMapping(value = "test", method = RequestMethod.GET)
    @ResponseBody

    public String getTest(HttpServletRequest request) {
        AppConfig.getJdbcTemplate().update("update goods set price = price + 1 where id =4");
        AppConfig.getJdbcTemplate().update("update goods set price = price + 2 where id =4");
        tt();
        return "";
    }

    @Transactional
    public void tt() {
        AppConfig.getJdbcTemplate().update("update goods set price = price + 3 where id =4");
        AppConfig.getJdbcTemplate().update("update goods set price = price + 4 where id =4");
    }

    @RequestMapping(value = "test1", method = RequestMethod.GET)
    @ResponseBody
    public String getTest1(Model model, HttpServletRequest request) {
        TemplateEngine templateEngine = AppConfig.getContext().getBean(TemplateEngine.class);
        Context context = new Context();
        context.setVariable("error", "msg");
        String html = templateEngine.process("default/error", context);
        return html;

    }

    @GetMapping(value = "msg")
    public ModelAndView getMsg(HttpServletRequest request, HttpServletResponse response) {
        Session session = Session.from(request);
        ModelAndView modelAndView = Helper.newModelAndView("msg", request);
        var msg = session.get("msg");
        if (msg == null) {
            try {
                response.sendRedirect("/");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        modelAndView.addObject("msg", msg);
        modelAndView.addObject("backUrl", session.get("backUrl"));
        session.delete("msg", "backUrl");
        modelAndView.addObject("title", msg);
        return modelAndView;
    }

    @GetMapping(path = "/session", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getSession(HttpServletRequest request) {
        Session session = Session.from(request);
        if (session.getId(false) == null) {
            return "{}";
        }
        Map<String, Object> map = new HashMap<>();
        map.put("sessionId", session.getId(false));
        session.getAll().forEach(map::put);
        return Helper.getJson(map);
    }

    @GetMapping(value = "/upload", produces = "text/html; charset=UTF-8")
    @ResponseBody
    public String getUpload(HttpServletRequest request) {
        System.out.println(Arrays.toString(request.getParameterValues("abc")));
        return "";
    }

    @PostMapping(value = "/upload", produces = "text/html; charset=UTF-8")
    @ResponseBody
    public String upload(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return "上传失败，请选择文件";
        }

        String fileName = file.getOriginalFilename();
        String filePath = LocalStorage.UPLOAD_DIR;
        File dest = new File(filePath + fileName);
        try {
            file.transferTo(dest);
            return "上传成功";
        } catch (IOException ignored) {
        }
        return "上传失败！";
    }
}
