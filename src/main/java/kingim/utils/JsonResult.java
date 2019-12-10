package kingim.utils;

public class JsonResult {

    private int    code;
    private String msg;
    private Object data;
    private long count = 1000L; //数据总量
    
    public JsonResult(){}

    public JsonResult(ResponseType type, Object obj){
        code = type.getCode();
        msg = type.getMsg();
        data = obj;
    }

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

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

	public long getCount() {
		return count;
	}

	public void setCount(long count) {
		this.count = count;
	}

    
}
