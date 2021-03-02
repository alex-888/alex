package alex.controller.admin.order;

import alex.entity.OrderEntity;
import alex.lib.AdminHelper;
import alex.lib.Helper;
import alex.lib.Pagination;
import alex.repository.OrderRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller(value = "admin/order/order")
@RequestMapping(path = "admin/order/order")
public class Order {

    @Resource
    OrderRepository orderRepository;

    /**
     * 编辑订单
     * @param request request
     * @return view
     */
    @GetMapping(value = "edit")
    public ModelAndView getEdit(HttpServletRequest request) {
        long no = Helper.longValue(request.getParameter("no"));
        OrderEntity order = orderRepository.findByNo(no);
        if (order == null) {
            return AdminHelper.msgPage("订单不存在", "/admin/order/order/list", request);
        }
        ModelAndView modelAndView = Helper.newModelAndView("admin/order/order/edit", request);
        modelAndView.addObject("order", order);
        modelAndView.addObject("title", "订单信息");
        return modelAndView;
    }

    /**
     * 订单列表
     * @param request request
     * @return view
     */
    @GetMapping(value = "list")
    public ModelAndView getList(HttpServletRequest request) {
        String sql = "SELECT o.consignee,o.createTime,o.id,o.no,o.payTime,o.price,o.status,o.userId,u.name as userName"
                + " FROM orders o LEFT JOIN users u ON o.userId = u.id";
        sql += " ORDER BY o.id DESC";
        Pagination pagination = new Pagination(sql, Helper.longValue(request.getParameter("page")));
        ModelAndView modelAndView = Helper.newModelAndView("admin/order/order/list", request);
        modelAndView.addObject("pagination", pagination);
        modelAndView.addObject("title", "订单列表");
        return modelAndView;
    }
}

