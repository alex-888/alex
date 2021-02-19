package alex.config;

import alex.authentication.AdminAuthException;
import alex.authentication.UserAuthException;
import alex.lib.Helper;
import alex.lib.JsonResult;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.security.auth.message.AuthException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@ControllerAdvice
public class GlobalExceptionHandler {
    private static final Log log = LogFactory.getLog(GlobalExceptionHandler.class.getName());

    /**
     * 管理员鉴权异常
     *
     * @param request  request
     * @param response response
     * @param e        exception
     * @return 异常处理结果
     */
    @ExceptionHandler(AdminAuthException.class)
    public ModelAndView adminAuthExceptionHandler(HttpServletRequest request, HttpServletResponse response, AdminAuthException e) {
        if (e.isDenied()) {
            if (request.getMethod().equals("GET")) {
                ModelAndView modelAndView = Helper.newModelAndView("error", request);
                modelAndView.addObject("statusCode", "");
                modelAndView.addObject("error", "无此权限");
                return modelAndView;
            } else {
                response.setContentType("application/json;charset=UTF-8");
                JsonResult jsonResult = new JsonResult();
                jsonResult.setMsg("无此权限");
                try {
                    response.getWriter().write(jsonResult.toString());
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
        } else {
            String loginUrl = "/admin/login";
            if (request.getMethod().equals("GET")) {
                loginUrl += "?back=" + Helper.urlEncode(request.getRequestURI());
                try {
                    response.sendRedirect(loginUrl);
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            } else {
                response.setContentType("application/json;charset=UTF-8");
                JsonResult jsonResult = new JsonResult();
                jsonResult.setUrl(loginUrl);
                try {
                    response.getWriter().write(jsonResult.toString());
                    response.getWriter().write(jsonResult.toString());
                } catch (IOException ex) {
                    ex.printStackTrace();
                }

            }
        }
        return null;
    }

    @ExceptionHandler(UserAuthException.class)
    public void userAuthExceptionHandler(HttpServletRequest request, HttpServletResponse response, UserAuthException e) {
        String loginUri = "/user/login";
        if (request.getMethod().equals("GET")) {
            loginUri += "?back=" + Helper.urlEncode(request.getRequestURI());
            String queryString = request.getQueryString();
            if (queryString != null) {
                loginUri += Helper.urlEncode('?' + queryString);
            }
            try {
                response.sendRedirect(loginUri);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        } else {
            JsonResult jsonResult = new JsonResult();
            jsonResult.setUrl(loginUri);
            try {
                response.getWriter().write(jsonResult.toString());
                response.getWriter().write(jsonResult.toString());
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }

    }

}
