package kingim.service.impl;

import java.text.SimpleDateFormat;
import java.util.*;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import kingim.dao.FriendMapper;
import kingim.dao.UserMapper;
import kingim.model.Friend;
import kingim.model.User;
import kingim.service.FriendService;
import kingim.utils.RedisUtils;
import kingim.vo.SNSMessage;
import kingim.vo.SNSMessageInit;
import kingim.vo.SNSUser;
import kingim.ws.LLWS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.common.Mapper;

import javax.websocket.Session;

/**
 * 好友Service
 */
@Service
public class FriendServiceImpl extends BaseServiceImpl<Friend> implements FriendService {

	@Autowired
	private FriendMapper friendMapper;

	@Autowired
	private UserMapper userMapper;

	@Override
	public Mapper<Friend> getMapper() {
		return friendMapper;
	}

	@Override
	public List<User> searchFriendByFriendId(int friendId) {
		return null;
	}

	@Override
	public List<User> searchFriendByRemarkName(String remarkName) {
		return null;
	}

	@Override
	public boolean isFriend(int userId, int friendId) {
		return false;
	}

	@Override
	public int delFriend(int userId, int friendId) {
		return 0;
	}

	@Override
	public int addFriend(int fromId, int toId, int from_group,int group) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date nowdate = new Date();
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("fromId",fromId);
		params.put("toId",toId);
		params.put("typeId",from_group);
		int existnum = friendMapper.findExistFriend(params);
		int savenum = -1;
		if(existnum == 0){//不存在则保存
			savenum = friendMapper.addFriend(params);
		}
		int save = -1;
		params.put("fromId",toId);
		params.put("toId",fromId);
		params.put("typeId",group);
		int existnum2 = friendMapper.findExistFriend(params);
		if(existnum2 == 0){
			save = friendMapper.addFriend(params);
		}
		SNSUser snsUser = userMapper.findSNSUserByUserID(toId);
		if(LLWS.mapUS.containsKey(fromId+"")) {//如果在线，通知对方添加好友成功
			net.sf.json.JSONObject toMessage=new net.sf.json.JSONObject();
			toMessage.put("avatar", snsUser.getAvatar());
			toMessage.put("sign", snsUser.getSign());
			toMessage.put("type","addFriendFanKui");
			toMessage.put("content", "我通过了你的好友认证请求");
			toMessage.put("timestamp",nowdate.getTime());
			toMessage.put("time",format.format(nowdate));
			toMessage.put("mine",false);
			toMessage.put("username",snsUser.getUsername());
			toMessage.put("group",from_group);
			toMessage.put("id", toId);
			Session session = LLWS.mapUS.get(fromId+"");
			synchronized(session) {
				try{
					session.getBasicRemote().sendText(toMessage.toString());
				}catch (Exception e){
					e.printStackTrace();
				}

			}
		}else{//不在线，通过消息盒子进行提醒。存入redis，登录之后可以看到提醒
			SNSMessage message = new SNSMessage();
			//		message.setId(0);
			message.setContent(snsUser.getUsername()+" 通过了你的好友申请");
			message.setFrom(null);
			message.setUid(fromId);
			message.setFrom_group(null);//添加请求方设置的好友分组id
			message.setType(1);
			message.setRead(1);
			message.setRemark(null);
			message.setTime(format.format(nowdate));
			message.setUser(null);
			RedisUtils.lpush(fromId + "_msgBox", JSON.toJSONString(message));
		}
		if((existnum > 0 || savenum > 0) && (existnum2 > 0 || save > 0)){
			return 1;
		}else{
			return -1;
		}
	}

	@Override
	public int getFriendCounts(int userId) {
		return 0;
	}

	@Override
	public List<String> getFriendsId(int userId) {
		return null;
	}

	@Override
	public void sendAddFriend(int from, int uid, int from_group,String remark) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String datetime = format.format(new Date());
		SNSMessage message = new SNSMessage();
//		message.setId(0);
		message.setContent("申请添加你为好友");
		message.setFrom(from);//请求方id
		message.setUid(uid);//被请求方id
		message.setFrom_group(from_group);//添加请求方设置的好友分组id
		message.setType(1);
		message.setRead(1);
		message.setRemark(remark);
		message.setTime(datetime);
		SNSUser snsUser = userMapper.findSNSUserByUserID(from);
		message.setUser(snsUser);
		RedisUtils.lpush(uid + "_msgBox", JSON.toJSONString(message));
		//消息盒子闪动提醒
		if(LLWS.mapUS.containsKey(uid+"")) {//如果在线，及时推送。如果不在线，上线后会通过Ajax查询
			JSONObject sysMessage=new JSONObject();
			sysMessage.put("type","system");
			Long len = RedisUtils.llen(uid + "_msgBox");
			sysMessage.put("num",len);
			Session session = LLWS.mapUS.get(uid+"");
			synchronized(session) {
				try{
					session.getBasicRemote().sendText(sysMessage.toString());               //发送系统消息给对方
				}catch (Exception e){
					e.printStackTrace();
				}
			}
		}
	}

	@Override
	public Map<String, Object> getFriend(int userId, int friendId) {
		List<Map<String, Object>> list = friendMapper.getFriend(userId,friendId);
		if(list != null && list.size() > 0){
			return list.get(0);
		}else{
			return null;
		}
	}

	@Override
	public Map<String, Object> getMineGroup(int uId, int groupId) {
		List<Map<String, Object>> list = friendMapper.getMineGroup(uId,groupId);
		if(list != null && list.size() > 0){
			return list.get(0);
		}else{
			return null;
		}
	}

	@Override
	public List<Map<String, Object>> friendTypeCount(int userId) {
		return friendMapper.friendTypeCount(userId);
	}

	@Override
	public List<Map<String, Object>> getFriendByTypeId(int typeId,int userId) {
		return friendMapper.getFriendByTypeId(typeId,userId);
	}

	@Override
	public int updateFriendType(int typeId, int friendId) {
		return friendMapper.updateFriendType(typeId,friendId);
	}

	@Override
	public int updateRemark(Map<String, Object> params) {
		return friendMapper.updateRemark(params);
	}

	@Override
	public int deleteFriendById(Map<String, Object> params) {
		return friendMapper.deleteFriendById(params);
	}

	@Override
	public int delFriendByFriendId(Map<String, Object> params) {
		return friendMapper.delFriendByFriendId(params);
	}

	@Override
	public int syncUser(Map<String, Object> params) {
		int result = 0;
		List<Map<String,Object>> syslist = friendMapper.findSysUserList(null);
		if(syslist != null && syslist.size() > 0){
			for(int i=0;i<syslist.size();i++){
				Map<String,Object> userMap = syslist.get(i);
				//id   loginId  loginPwd  userName
				//查找是否存在用户
				List<Map<String,Object>> tUserList = friendMapper.findUserBySysUserIdList(userMap);
				if(tUserList == null || tUserList.size() == 0){
					result = userMapper.addUser(userMap);
				}
			}
		}
		return result;
	}

}
