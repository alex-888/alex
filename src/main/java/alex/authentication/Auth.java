package alex.authentication;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public abstract class Auth {

    private ServletRequestAttributes getAttributes() {
        return (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
    }

    protected HttpServletRequest getRequest() {

        return getAttributes().getRequest();
    }

    protected HttpServletResponse getResponse() {
        return getAttributes().getResponse();
    }
}
