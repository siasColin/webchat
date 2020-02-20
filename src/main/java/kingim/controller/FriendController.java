package kingim.controller;

import java.text.SimpleDateFormat;
import java.util.*;

import com.alibaba.fastjson.JSON;
import kingim.model.FriendType;
import kingim.service.FriendService;
import kingim.service.FriendTypeService;
import kingim.utils.RedisUtils;
import kingim.vo.SNSMessage;
import kingim.vo.SNSUser;
import kingim.ws.LLWS;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import kingim.model.User;
import kingim.service.UserService;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.websocket.Session;

@Controller
@RequestMapping("/friend")
public class FriendController {

	@Autowired
	UserService userService;
    @Autowired
    private FriendService friendService;
    @Autowired
    private FriendTypeService friendTypeService;
	
    @RequestMapping(value="/init/{userId}",produces = "text/plain; charset=utf-8")
    @ResponseBody
    public String init(@PathVariable("userId")int userId){
        User user = userService.getUserById(userId);
        Map<String, Object> map = new HashMap<>();
        Map<String, Object> mine = new HashMap<>();
        mine.put("username", user.getNickName());
        mine.put("id", user.getId());
        mine.put("status", "online");
        mine.put("sign", user.getSign());
        mine.put("avatar", user.getAvatar());
        map.put("mine", mine);
        return JSON.toJSONString(map);
    }
    @RequestMapping(value = "agreeFriend",produces = "application/json; charset=utf-8")
    public @ResponseBody
    JSONObject agreeFriend(int from, int from_group, int uid, int group) {
        JSONObject returnObj = new JSONObject();
        int savenum = friendService.addFriend(from,uid,from_group,group);
        if(savenum > 0){
            returnObj.put("code","0");
            returnObj.put("msg","");
        }else{
            returnObj.put("code","1");
            returnObj.put("msg","添加好友失败");
        }
        return returnObj;
    }

    /**
     * 发送添加好友申请
     * @param from 申请方用户id
     * @param from_group 申请方设置的分组id
     * @param uid 被申请方用户id
     * @param remark 验证信息
     * @return
     */
    @RequestMapping(value = "sendAddFriend",produces = "application/json; charset=utf-8")
    public @ResponseBody
    JSONObject sendAddFriend(int from, int from_group, int uid,String remark) {
        JSONObject returnObj = new JSONObject();
        returnObj.put("code","1");
        returnObj.put("msg","添加好友失败");
        friendService.sendAddFriend(from,uid,from_group,remark);
        returnObj.put("code","0");
        returnObj.put("msg","");
        return returnObj;
    }

    @RequestMapping(value = "refuseFriend",produces = "application/json; charset=utf-8")
    public @ResponseBody
    JSONObject refuseFriend(int from,String username) {
        JSONObject returnObj = new JSONObject();
        returnObj.put("code","1");
        returnObj.put("msg","拒绝添加好友失败");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String datetime = format.format(new Date());
        SNSMessage message = new SNSMessage();
//		message.setId(0);
        message.setContent(username+" 拒绝了你的好友申请");
        message.setFrom(null);
        message.setUid(from);
        message.setFrom_group(null);//添加请求方设置的好友分组id
        message.setType(1);
        message.setRead(1);
        message.setRemark(null);
        message.setTime(datetime);
        message.setUser(null);
        RedisUtils.lpush(from + "_msgBox", JSON.toJSONString(message));
        //消息盒子闪动提醒
        if(LLWS.mapUS.containsKey(from+"")) {//如果在线，及时推送。如果不在线，上线后会通过Ajax查询
            com.alibaba.fastjson.JSONObject sysMessage=new com.alibaba.fastjson.JSONObject();
            sysMessage.put("type","system");
            Long len = RedisUtils.llen(from + "_msgBox");
            sysMessage.put("num",len);
            Session session = LLWS.mapUS.get(from+"");
            synchronized(session) {
                try{
                    session.getBasicRemote().sendText(sysMessage.toString());               //发送系统消息给对方
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        returnObj.put("code","0");
        returnObj.put("msg","");
        return returnObj;
    }
    @RequestMapping(value = "/friendManage")
    public String friendManage(HttpServletRequest request){
        int userId = request.getParameter("userId") == null ? -1 : Integer.parseInt(request.getParameter("userId"));
        if(userId != -1){
            //查询用户所有分组
            List<Map<String,Object>> resultList = friendService.friendTypeCount(userId);
            int allFirendNum = 0;
            if(resultList != null && resultList.size() > 0){
                for (Map<String,Object> result : resultList) {
                    allFirendNum += Integer.parseInt(result.get("total").toString());
                }
            }
            List<Map<String,Object>> mineFriendTypeList = new ArrayList<Map<String,Object>>();
            Map<String,Object> mineFriendType = new HashMap<String,Object>(3);
            mineFriendType.put("id",-1);
            mineFriendType.put("type_name","全部");
            mineFriendType.put("total",allFirendNum);
            mineFriendTypeList.add(mineFriendType);
            mineFriendTypeList.addAll(resultList);
            request.setAttribute("mineFriendTypeList",mineFriendTypeList);
        }
        return "friend";
    }

    @RequestMapping(value = "getFriendByTypeId",produces = "application/json; charset=utf-8")
    public @ResponseBody Object getFriendByTypeId(int typeId,int userId) {
        Map<String,Object> returnMap = new HashMap<String,Object>();
        returnMap.put("code",-1);
        returnMap.put("msg","加载好友失败！");
        List<Map<String,Object>> friendList = friendService.getFriendByTypeId(typeId,userId);
        returnMap.put("data",friendList);
        returnMap.put("code",0);
        returnMap.put("msg","");
        return returnMap;
    }
    @RequestMapping("/addFriendTypePage")
    public String addFriendTypePage(HttpServletRequest request){
        if(request.getParameter("userId") != null){
            request.setAttribute("userId",request.getParameter("userId").toString());
        }
        return "friendTypeAdd";
    }
    @RequestMapping(value = "addFriendType",produces = "application/json; charset=utf-8")
    public @ResponseBody Object addFriendType(int userId,String groupName) {
        Map<String,Object> returnMap = new HashMap<String,Object>();
        returnMap.put("code",-1);
        returnMap.put("msg","添加分组失败！");
        //保存入库
        FriendType friendType = friendTypeService.addFriendType(userId,groupName,0);
        returnMap.put("code",0);
        returnMap.put("msg",friendType.getId());
        return returnMap;
    }

    @RequestMapping(value = "updateFriendType",produces = "application/json; charset=utf-8")
    public @ResponseBody Object updateFriendType(int typeId,int friendId) {
        Map<String,Object> returnMap = new HashMap<String,Object>();
        returnMap.put("code",-1);
        returnMap.put("msg","移动好友失败！");
        int updateNum = friendService.updateFriendType(typeId,friendId);
        returnMap.put("code",0);
        returnMap.put("msg","");
        return returnMap;
    }
    
    
    @RequestMapping(value = "updateRemark",produces = "application/json; charset=utf-8")
    public @ResponseBody Object updateRemark(String id,String remark) {
        Map<String,Object> returnMap = new HashMap<String,Object>();
        returnMap.put("code",-1);
        returnMap.put("msg","更新备注失败！");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("id", id);
        params.put("remark", remark);
        int updateNum = friendService.updateRemark(params);
        if(updateNum > 0){
        	returnMap.put("code",0);
            returnMap.put("msg","");
        }
        
        return returnMap;
    }
    
    @RequestMapping(value = "deleteFriendById",produces = "application/json; charset=utf-8")
    public @ResponseBody Object deleteFriendById(String id) {
        Map<String,Object> returnMap = new HashMap<String,Object>();
        returnMap.put("code",-1);
        returnMap.put("msg","删除好友失败！");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("id", id);
        int updateNum = friendService.deleteFriendById(params);
        returnMap.put("code",0);
        returnMap.put("msg","删除成功");
        return returnMap;
    }
    
    
    @RequestMapping("/searchPage")
    public String searchPage(HttpServletRequest request) {
    	String userId = request.getParameter("userId");
    	Map<String,Object> params = new HashMap<String, Object>();
    	params.put("userId", userId);
    	List<User> listuser = userService.findUserList(params);
    	int count = listuser == null?0:listuser.size();
    	request.setAttribute("count", count);
        return "search";
    }
    
    @RequestMapping("/searchFriendPage")
    public String searchFriendPage(HttpServletRequest request) {
    	List<User> listuser = userService.findUserList(null);
    	int count = listuser == null?0:listuser.size();
    	request.setAttribute("count", count);
        return "searchFriends";
    }
    
    
    @RequestMapping(value = "deleteFriendTypeById",produces = "application/json; charset=utf-8")
    public @ResponseBody Object deleteFriendTypeById(String id) {
        Map<String,Object> returnMap = new HashMap<String,Object>();
        returnMap.put("code",-1);
        returnMap.put("msg","删除好友失败！");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("id", id);
        FriendType  friendType = friendTypeService.findFriendTypeById(params);
        List<Map<String,Object>> listuser = friendService.getFriendByTypeId(friendType.getId(), friendType.getUserId());
        
        if(friendType.getIsDefault() == 1){
        	returnMap.put("code",1);
            returnMap.put("msg","默认群组不能删除！");
            return returnMap;
        }else if(listuser.size() > 0){
        	returnMap.put("code",2);
            returnMap.put("msg","群组下存在好友不能删除！");
            return returnMap;
        }else{
        	int updateNum = friendTypeService.delById(params);
            returnMap.put("code",0);
            returnMap.put("msg","删除群组成功");
        }
        return returnMap;
    }
    
    @RequestMapping("/updateFriendTypePage")
    public String updateFriendTypePage(HttpServletRequest request){
    	String id = request.getParameter("id");
    	Map<String,Object> params = new HashMap<String,Object>();
        params.put("id", id);
        FriendType  friendType = friendTypeService.findFriendTypeById(params);
        request.setAttribute("friendType", friendType);
        return "friendTypeUpdate";
    }
    
    
    @RequestMapping(value = "updateFriendTypeName",produces = "application/json; charset=utf-8")
    public @ResponseBody Object updateFriendTypeName(String id,String typeName) {
        Map<String,Object> returnMap = new HashMap<String,Object>();
        returnMap.put("code",-1);
        returnMap.put("msg","删除好友失败！");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("id", id);
        params.put("typeName", typeName);
        int updateNum = friendTypeService.updateFriendTypeName(params);
        returnMap.put("code",0);
        returnMap.put("msg","删除成功");
        return returnMap;
    }
    

    @RequestMapping(value = "deleteFriendByFriendId",produces = "application/json; charset=utf-8")
    public @ResponseBody Object deleteFriendByFriendId(String userId,String friendId) {
        Map<String,Object> returnMap = new HashMap<String,Object>();
        returnMap.put("code",-1);
        returnMap.put("msg","删除好友失败！");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("userId", userId);
        params.put("friendId", friendId);
        try{
            int updateNum = friendService.delFriendByFriendId(params);
            if(updateNum > 0){
                returnMap.put("code",0);
                returnMap.put("msg","删除成功");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return returnMap;
    }
    
    
    @RequestMapping(value = "syncSysUser",produces = "application/json; charset=utf-8")
    public @ResponseBody Object syncSysUser(String id) {
        Map<String,Object> returnMap = new HashMap<String,Object>();
        returnMap.put("code",-1);
        returnMap.put("msg","同步好友失败！");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("id", id);
        int addNum = friendService.syncUser(null);
        if(addNum > 0){
        	 returnMap.put("code",0);
             returnMap.put("msg","同步成功");
        }
        return returnMap;
    }
    
    @RequestMapping("/test")
    public String test(){
        System.out.println("------------------------");
       return "main";
    }
}