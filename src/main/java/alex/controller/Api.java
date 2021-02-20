package alex.controller;

import alex.config.AppConfig;
import alex.lib.ApiJsonResult;
import alex.lib.Helper;
import alex.service.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.boot.SpringApplication;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping(path = "/api")
public class Api {

    @GetMapping(path = "/error", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getError() {
        AppConfig.getJdbcTemplate().execute("select now11()");
        return Helper.getJson("");
    }

    @PostMapping(path = "login", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String postLogin(
            String name,
            @RequestParam String password
    ) {
        ApiJsonResult apiJsonResult = new ApiJsonResult();
        return apiJsonResult.toString();
    }

    @GetMapping(path = "/info", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getInfo() {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, String> map = new HashMap<>();
        map.put("java.vendor", System.getProperty("java.vendor"));
        map.put("java.version", System.getProperty("java.version"));
        map.put("java.home", System.getProperty("java.home"));
        map.put("java.vm.name", System.getProperty("java.vm.name"));
        map.put("java.vm.version", System.getProperty("java.vm.version"));
        map.put("java.runtime.name", System.getProperty("java.runtime.name"));
        map.put("os.name", System.getProperty("os.name"));
        map.put("os.version", System.getProperty("os.version"));
        map.put("springboot.version", SpringApplication.class.getPackage().getImplementationVersion());
        map.put("user.dir", System.getProperty("user.dir"));
        return Helper.getJson(map);


    }

    @GetMapping(path = "/now", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getNow() {
        Map<String, Object> map = new HashMap<>();
        map.put("now", new Date().toString());
        return Helper.getJson(map);
    }


    @GetMapping(path = "/test", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getTest(HttpServletRequest request) {
        request.getRequestURI();
        return null;
    }
    //Principal

    @GetMapping(path = "/user", produces = MediaType.APPLICATION_JSON_VALUE)
    public String getUser() {
        UserService userService = AppConfig.getContext().getBean(UserService.class);
        for (int i = 101; i< 1000; i++) {
            userService.register("user" + i, "111111", "localhost");
        }
        return "";
    }

}
