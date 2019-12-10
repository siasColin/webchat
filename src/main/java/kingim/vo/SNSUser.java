package kingim.vo;

public class SNSUser {
	
	private Integer id;            //我的ID,即userId
	private String username;   //我的真是姓名，即ucName
	private String status;     //在线状态 online：在线、hide：隐身
	private String sign;       //我的签名
	private String avatar;     //我的头像
	private String remark;
	private Integer groupUserId;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Integer getGroupUserId() {
		return groupUserId;
	}
	public void setGroupUserId(Integer groupUserId) {
		this.groupUserId = groupUserId;
	}
    
}
