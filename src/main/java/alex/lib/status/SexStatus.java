package alex.lib.status;

/**
 * 性别状态
 */
public enum SexStatus {
    UNKNOWN(0L, "未知"),
    MALE(1L, "男"),
    FEMALE(2L, "女");
    long code;
    String info;
    SexStatus(long code, String info) {
        this.code = code;
        this.info = info;
    }
    public long getCode() {
        return code;
    }

    public String getInfo() {
        return info;
    }

    public static SexStatus getInstance(long code) {
        for (var item : SexStatus.values()) {
            if (item.code == code) {
                return item;
            }
        }
        return null;
    }
    public static String getStatusInfo(long code) {
        var item = getInstance(code);
        if (item == null) {
            return null;
        }
        return item.getInfo();
    }

}
