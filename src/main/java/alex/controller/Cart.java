package alex.controller;

import alex.authentication.UserToken;
import alex.cache.GoodsCache;
import alex.cache.GoodsSpecCache;
import alex.entity.GoodsEntity;
import alex.entity.UserAddressEntity;
import alex.lib.Helper;
import alex.lib.HelperUtils;
import alex.lib.JsonResult;
import alex.repository.UserAddressRepository;
import alex.service.OrderService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;

@Controller
@RequestMapping(path = "cart")
public class Cart {

    @Resource
    OrderService orderService;

    @Resource
    UserAddressRepository userAddressRepository;

    @GetMapping(path = "")
    public ModelAndView getIndex(HttpServletRequest request) {
        var cart = new alex.lib.Cart(request);
        ModelAndView modelAndView = Helper.newModelAndView("cart/index", request);
        modelAndView.addObject("cartItems", cart.getItems());
        return modelAndView;
    }

    /**
     * 商品加入购物车
     *
     * @param request req
     * @return 视图
     */
    @GetMapping(path = "add")
    public ModelAndView getAdd(HttpServletRequest request) {
        long goodsId = Helper.longValue(request.getParameter("gid"));
        long specId = Helper.longValue(request.getParameter("specId"));
        long num = Helper.longValue(request.getParameter("num"));
        GoodsEntity goodsEntity = GoodsCache.getGoodsEntity(goodsId);
        var goodsSpecEntities = GoodsSpecCache.getGoodsSpecEntities(goodsId);
        var cart = new alex.lib.Cart(request);
        cart.add(goodsId, specId, num);
        //ModelAndView modelAndView = Helper.newModelAndView("cart/add", request);
        //modelAndView.addObject("goodsEntity", goodsEntity);
        //return modelAndView;
        return Helper.msgPage("已加入购物车", "/goods/" + goodsEntity.getId() + ".html", request);
    }

    @GetMapping(path = "buy")
    public ModelAndView getBuy(HttpServletRequest request) {
        var cart = new alex.lib.Cart(request);
        if (cart.sumNum() == 0) {
            return Helper.msgPage("购物车中没有选中的商品", "/cart", request);
        }
        UserToken userToken = (UserToken) request.getAttribute(UserToken.KEY);
        var addresses = userAddressRepository.findAllByUserId(userToken.getId());
        long addrId = Helper.longValue(request.getParameter("addrId"));
        UserAddressEntity address = null;
        for (var addr : addresses) {
            if (addr.getId() == addrId) {
                address = addr;
                break;
            }
        }
        if (address == null && addresses.size() > 0) {
            address = addresses.get(0);
            addrId = address.getId();
        }
        ModelAndView modelAndView = Helper.newModelAndView("cart/buy", request);
        modelAndView.addObject("addresses", addresses);
        modelAndView.addObject("address", address);

        for (var item : cart.getItems()) {
            item.setGoodsImg(HelperUtils.imgZoom(item.getGoodsImg(), 60, 60));
        }
        modelAndView.addObject("addrId", addrId);
        modelAndView.addObject("cart", cart);
        //运费
        long shippingFee = 0;
        if (address != null) {
            shippingFee = cart.shippingFee(address.getRegion());
        }
        modelAndView.addObject("shippingFee", shippingFee);
        modelAndView.addObject("title", "结算");
        return modelAndView;
    }


    /**
     * 提交订单
     *
     * @param request req
     * @return re
     */
    @PostMapping(path = "buy", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String postBuy(HttpServletRequest request) {
        JsonResult jsonResult = new JsonResult();
        long addrId = Helper.longValue(request.getParameter("addrId"));
        // 验证提交时的运费和商品价格
        long shippingFee = Helper.bigDecimalValue(request.getParameter("shippingFee")).multiply(new BigDecimal(100)).longValue();
        long sumPrice = Helper.bigDecimalValue(request.getParameter("sumPrice")).multiply(new BigDecimal(100)).longValue();
        alex.lib.Cart cart = new alex.lib.Cart(request);
        var orderInfo = orderService.addOrder(
                addrId,cart,sumPrice,shippingFee
        );
        if (orderInfo.getErr() != null) {
            return jsonResult.setMsg(orderInfo.getErr()).toString();
        }
        jsonResult.setMsg("已完成下单");
        return Helper.msgPage(jsonResult, request);
    }

    @GetMapping(path = "json", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String getJson(HttpServletRequest request) {
        long goodsId = Helper.longValue(request.getParameter("goodsId"));
        long specId = Helper.longValue(request.getParameter("specId"));
        boolean selected = Helper.longValue(request.getParameter("selected")) > 0;
        long num = Helper.longValue(request.getParameter("num"));
        long imgWidth = Helper.longValue(request.getParameter("w"));
        if (imgWidth <= 0) {
            imgWidth = 60;
        }
        String method = request.getParameter("m");
        if (method == null) {
            method = "";
        }

        String json = null;
        var cart = new alex.lib.Cart(request);
        switch (method) {
            case "add":
                cart.add(goodsId, specId, num);
                break;
            case "clear":
                cart.clear();
                break;
            case "del":
                cart.del(goodsId, specId);
                break;
            case "selected":
                cart.setSelected(goodsId, specId, selected);
                break;
            case "selectedAll":
                cart.setSelectedAll(selected);
                break;
            case "sub":
                cart.sub(goodsId, specId, num);
                break;
        }

        for (var item : cart.getItems()) {
            item.setGoodsImg(HelperUtils.imgZoom(item.getGoodsImg(), imgWidth, imgWidth));
        }
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            json = objectMapper.writeValueAsString(cart.getItems());
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return json;
    }
}
