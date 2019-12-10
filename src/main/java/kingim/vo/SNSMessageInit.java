package kingim.vo;

import java.util.List;

/**
 * Created by sxf on 2019-11-23.
 */
public class SNSMessageInit {
    //code=0 表示成功，其余表示失败
    private int code;
    //总页数
    private int pages;
    private List<SNSMessage> data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public int getPages() {
        return pages;
    }

    public void setPages(int pages) {
        this.pages = pages;
    }

    public List<SNSMessage> getData() {
        return data;
    }

    public void setData(List<SNSMessage> data) {
        this.data = data;
    }
}
