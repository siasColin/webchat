package kingim.vo;

/**
 * Created by sxf on 2019-11-23.
 */
public class SNSMessage {
    private Integer id;
    private String content;
    private Integer uid;
    private Integer from;
    private Integer from_group;
    private Integer type;
    private String remark;
    private String href;
    private Integer read;
    private String time;
    private SNSUser user;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getFrom() {
        return from;
    }

    public void setFrom(Integer from) {
        this.from = from;
    }

    public Integer getFrom_group() {
        return from_group;
    }

    public void setFrom_group(Integer from_group) {
        this.from_group = from_group;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public Integer getRead() {
        return read;
    }

    public void setRead(Integer read) {
        this.read = read;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public SNSUser getUser() {
        return user;
    }

    public void setUser(SNSUser user) {
        this.user = user;
    }
}
