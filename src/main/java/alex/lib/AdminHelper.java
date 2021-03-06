package alex.lib;

import alex.lib.session.Session;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

public class AdminHelper {

    public static String msgPage(JsonResult jsonResult, HttpServletRequest request) {
        Session session = Session.from(request);
        session.set("msg", jsonResult.getMsg());
        jsonResult.setMsg(null);
        String url = jsonResult.getUrl();
        if (url != null) {
            if (!url.startsWith("/")) {
                String uri = request.getRequestURI();
                url = uri.substring(0, uri.lastIndexOf("/") + 1) + url;
            }
            session.set("backUrl", url);
        }
        jsonResult.setUrl("/admin/msg");
        return jsonResult.toString();
    }

    public static ModelAndView msgPage(String msg, String backUrl, HttpServletRequest request) {
        ModelAndView modelAndView = Helper.newModelAndView("admin/msg", request);
        modelAndView.addObject("msg", msg);
        modelAndView.addObject("backUrl", backUrl);
        modelAndView.addObject("title", msg);
        return modelAndView;
    }
}
