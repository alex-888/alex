package alex.authentication;

import alex.cache.CategoryCache;
import alex.cache.SystemCache;
import alex.lib.session.ApiSession;
import alex.lib.session.Session;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.Date;

@Aspect
@Component
@Order(1)
public class GlobalAuth extends Auth {
    @Pointcut("execution(public * alex.controller..*(..))")
    public void pointcut() {
    }

    @Before("pointcut()")
    public void auth(JoinPoint joinPoint) {
        var request = getRequest();
        String uri = request.getRequestURI();
        if (uri.startsWith("/api/")) {
            new ApiSession(request);
            request.setAttribute(UserToken.NAME, UserToken.from("token"));
        } else {
            Session session = new Session(request, getResponse());
            request.setAttribute(UserToken.NAME, UserToken.from(session));
        }
        request.setAttribute("beian", SystemCache.getBeian());
        request.setAttribute("siteName", SystemCache.getName());
        request.setAttribute("siteUrl", SystemCache.getUrl());
        request.setAttribute("categoryNodes", CategoryCache.getNodes());
        request.setAttribute("keywords", SystemCache.getKeywords());
        request.setAttribute("now", new Date());
    }
}
