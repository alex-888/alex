package alex.controller.admin.order;

import alex.lib.Helper;
import alex.lib.Pagination;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller(value = "admin/order/order")
@RequestMapping(path = "admin/order/order")
public class Order {
    @GetMapping(value = "list")
    public ModelAndView getList(HttpServletRequest request) {
        Pagination pagination = new Pagination("select * from orders order by id desc",
                Helper.longValue(request.getParameter("page")));
        ModelAndView modelAndView = Helper.newModelAndView("admin/order/order/list", request);
        modelAndView.addObject("pagination", pagination);
        modelAndView.addObject("title", "订单列表");
        return modelAndView;
    }
}

