package alex.controller.user;

import alex.authentication.UserToken;
import alex.entity.OrderEntity;
import alex.entity.OrderGoodsEntity;
import alex.lib.Helper;
import alex.lib.Pagination;
import alex.repository.OrderGoodsRepository;
import alex.repository.OrderRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(path = "user/order")
public class Order {

    @Resource
    OrderRepository orderRepository;

    @Resource
    OrderGoodsRepository orderGoodsRepository;

    /**
     * 订单详情
     * @param request request
     * @return view
     */
    @GetMapping(path = "detail")
    public ModelAndView getDetail(HttpServletRequest request) {
        UserToken userToken = (UserToken) request.getAttribute(UserToken.NAME);
        // 订单号
        long no = Helper.longValue(request.getParameter("no"));
        OrderEntity orderEntity = orderRepository.findByNo(no);
        if (orderEntity == null || orderEntity.getUserId() != userToken.getId()) {
            return Helper.msgPage("订单不存在", null, request);
        }
        List<OrderGoodsEntity> goodsList = orderGoodsRepository.findAllByOrderId(orderEntity.getId());

        ModelAndView modelAndView = Helper.newModelAndView("user/order/detail", request);
        modelAndView.addObject("goodsList", goodsList);
        modelAndView.addObject("order", orderEntity);
        modelAndView.addObject("title", "订单详情");

        return modelAndView;
    }
    @GetMapping(path = "")
    public ModelAndView getIndex(HttpServletRequest request) {
        UserToken userToken = (UserToken) request.getAttribute(UserToken.NAME);
        long page = Helper.longValue(request.getParameter("page"));
        ModelAndView modelAndView = Helper.newModelAndView("user/order/index", request);
        var sql = String.format("select * from orders where userId = %d order by id desc", userToken.getId());
        Pagination pagination = new Pagination(sql, null, 15, page, null);
        for (var row : pagination.getRows()) {
            row.put("goodsList", orderGoodsRepository.findAllByOrderId(Helper.longValue(row.get("id"))));
        }
        modelAndView.addObject("pagination", pagination);
        modelAndView.addObject("title", "我的订单");
        return modelAndView;
    }
}
