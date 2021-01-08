package alex.controller.user;

import alex.authentication.UserToken;
import alex.lib.Helper;
import alex.lib.Pagination;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(path = "user/order")
public class Order {
    @GetMapping(path = "")
    public ModelAndView getIndex(HttpServletRequest request) {
        UserToken userToken = (UserToken) request.getAttribute(UserToken.KEY);
        long page = Helper.longValue(request.getParameter("page"));
        ModelAndView modelAndView = Helper.newModelAndView("user/order/index", request);
        var sql = String.format("select * from orders where userId = %d order by id desc", userToken.getId());
        Pagination pagination = new Pagination(sql, page);
        modelAndView.addObject("pagination", pagination);
        modelAndView.addObject("title", "我的订单");
        return modelAndView;
    }
}
