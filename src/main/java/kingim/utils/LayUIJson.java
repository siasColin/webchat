package kingim.utils;
import com.alibaba.fastjson.JSONObject;
/**
 * layUI table表格接收数据json格式
 * @author 李绍振
 */
public class LayUIJson {

    private  int code = 0; //成功标示
    private String msg = "操作成功";// 提示信息
    private long count = 1000L; //数据总量
    private Object data;// 数据

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public String getJsonStr(){
        JSONObject obj = new JSONObject();
        obj.put("code", this.code);
        obj.put("msg", this.getMsg());
        obj.put("count", this.count);
        obj.put("data", this.data);
        return obj.toJSONString();
    }
}
