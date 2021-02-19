package alex.authentication;

/**
 * 管理员鉴权异常类,在未登录或无权限时抛出
 */
public class AdminAuthException extends Exception {
    // 权限不足
    private final boolean denied;


    /**
     * @param denied 是否权限不足，true:无此权限 false:未登录
     */
    public AdminAuthException(boolean denied) {
        this.denied = denied;
    }

    /**
     * @return true:无此权限 false:未登录
     */
    public boolean isDenied() {
        return denied;
    }
}
