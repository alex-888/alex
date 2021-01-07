package alex.controller;

import alex.cache.CategoryCache;
import alex.entity.GoodsEntity;
import alex.lib.Helper;
import alex.repository.GoodsRepository;
import alex.repository.GoodsSpecRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(path = "goods")
public class Goods {

    @Resource
    GoodsRepository goodsRepository;

    @Resource
    GoodsSpecRepository goodsSpecRepository;

    @GetMapping(path = "{goodsId:\\d+}.html")
    public ModelAndView getIndex(
            @PathVariable long goodsId,
            HttpServletRequest request) {
        GoodsEntity goodsEntity = goodsRepository.findById(goodsId).orElse(null);
        if (goodsEntity == null) {
            return Helper.msgPage("商品不存在", "", request);
        }
        String[] goodsImgs = goodsEntity.getImgs().split(",");
        String specItems = null;
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            specItems = objectMapper.writeValueAsString(goodsSpecRepository.findByGoodsId(goodsId));
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        if (specItems == null || specItems.length() < 10) {
            specItems = "[]";
        }
        ModelAndView modelAndView = Helper.newModelAndView("goods/index", request);
        modelAndView.addObject("categoryPath", CategoryCache.getCategoryPath(goodsEntity.getCateId()));
        modelAndView.addObject("goodsEntity", goodsEntity);
        modelAndView.addObject("goodsImgs", goodsImgs);
        modelAndView.addObject("specItems", specItems);
        return modelAndView;
    }
}
