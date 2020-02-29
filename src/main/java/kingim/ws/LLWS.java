package kingim.ws;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import kingim.service.FriendService;
import kingim.service.MessageService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import kingim.utils.RedisUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.web.socket.server.standard.SpringConfigurator;

@ServerEndpoint(value = "/LLWS/{userId}",configurator = SpringConfigurator.class)
public class LLWS {

	private static Logger logger = Logger.getLogger(LLWS.class);

	@Autowired
	QunWS qunWS;
	@Autowired
	MessageService messageService;
	@Autowired
	private FriendService friendService;
	
    //ConcurrentHashMap是线程安全的，而HashMap是线程不安全的。
    public static ConcurrentHashMap<String,Session> mapUS = new ConcurrentHashMap<String,Session>();
	public static ConcurrentHashMap<Session,String> mapSU = new ConcurrentHashMap<Session,String>();

    //连接建立成功调用的方法
	@OnOpen
	public void onOpen(Session session,@PathParam("userId") Integer userId) {
		String jsonString="{'content':'online','id':"+userId+",'type':'onlineStatus'}";
		session.setMaxIdleTimeout(1800000);
		for (String value : mapSU.values()) {
			try {
				mapUS.get(value).getBasicRemote().sendText(jsonString);
			} catch (IOException e) {
				logger.error(e);
			}
		}
		mapUS.put(userId+"",session);
		mapSU.put(session,userId+"");
		//更新redis中的用户在线状态
		RedisUtils.set(userId+"_status","online");
		logger.info("用户"+userId+"进入llws,当前在线人数为" + mapUS.size() );

	}
  
    //连接关闭调用的方法 
    @OnClose  
    public void onClose(Session session) { 
    	String userId=mapSU.get(session);
    	if(userId!=null&&userId!=""){
    	 	//更新redis中的用户在线状态
    		RedisUtils.set(userId+"_status","offline");
        	mapUS.remove(userId);
        	mapSU.remove(session);
			logger.info("用户"+userId+"退出llws,当前在线人数为" + mapUS.size());
    	}
    }  
  
    // 收到客户端消息后调用的方法 
    @OnMessage  
    public void onMessage(String message, Session session) {  
    	   JSONObject jsonObject=JSONObject.fromObject(message);
           String type = jsonObject.getJSONObject("to").getString("type");
           if(type.equals("onlineStatus")){
				for(Session s:session.getOpenSessions()){		//循环发给所有在线的人
				   JSONObject toMessage=new JSONObject();
	               toMessage.put("id", jsonObject.getJSONObject("mine").getString("id"));  
	               toMessage.put("content", jsonObject.getJSONObject("mine").getString("content"));
	               toMessage.put("type",type);
					for (String value : mapSU.values()) {
						try {
							mapUS.get(value).getBasicRemote().sendText(toMessage.toString());
						} catch (IOException e) {
							logger.error(e);
						}
					}
				}
           }else{
               int toId=jsonObject.getJSONObject("to").getInt("id");
               SimpleDateFormat df = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");    
               Date date = new Date();
               String time=df.format(date);    
               jsonObject.put("time", time); 
               JSONObject toMessage=new JSONObject();
               toMessage.put("avatar", jsonObject.getJSONObject("mine").getString("avatar"));  
               toMessage.put("type",type);      
               toMessage.put("content", jsonObject.getJSONObject("mine").getString("content"));   
               toMessage.put("timestamp",date.getTime()); 
               toMessage.put("time",time); 
               toMessage.put("mine",false);
               toMessage.put("username",jsonObject.getJSONObject("mine").getString("username"));   
    	   	    if(type.equals("friend")||type.equals("fankui")){
    	   	    	   toMessage.put("id", jsonObject.getJSONObject("mine").getInt("id"));    
    	   	    }else{
    	   	    	   toMessage.put("id", jsonObject.getJSONObject("to").getInt("id"));   
    	   	    }        
               switch (type) {
    		   		case "friend":           							 //单聊,记录到mongo
						  /***查询对方设置的备注start，如果聊天框内不需要显示备注（只显示用户昵称）可以注释掉这段毕竟每次发送查询耗时***/
						  int friendId = jsonObject.getJSONObject("mine").getInt("id");//对方好友列表中发送方的id
						int userId = jsonObject.getJSONObject("to").getInt("id");//对方用户id
						  Map<String,Object> friendMap = friendService.getFriend(userId,friendId);
						  if(friendMap != null && friendMap.get("remark") != null && !"".equals(friendMap.get("remark").toString())){
							  toMessage.put("username",friendMap.get("remark").toString());
						  }
						  /***查询对方设置的备注end，如果聊天框内不需要显示备注（只显示用户昵称）可以注释掉这段毕竟每次发送查询耗时***/
    			    	  if(mapUS.containsKey(toId+"")){               //如果在线，及时推送
							  session = mapUS.get(toId+"");
							  synchronized(session) {
							  	try{
									session.getBasicRemote().sendText(toMessage.toString());
								}catch (Exception e){
									e.printStackTrace();
								}

							  }
//    			  			 mapUS.get(toId+"").getAsyncRemote().sendText(toMessage.toString());               //发送消息给对方
							  logger.info("单聊-来自客户端的消息:" + toMessage.toString());
    			    	  }else{                                        //如果不在线 就记录到数据库，下次对方上线时推送给对方。
    			    		RedisUtils.lpush(toId + "_msg", toMessage.toString());
							  logger.info("单聊-对方不在线，消息已存入redis:" + toMessage.toString());
    			    	  }
    			    	  //存入数据库，方便查询聊天记录
						int savenum = messageService.saveFriendMessage(jsonObject);
    		   			break;
    		   		case "group":
						/***查询群备注名称start，如果聊天框内不需要显示备注（只显示用户昵称）可以注释掉这段毕竟每次发送查询耗时***/
						int groupId = toId;//对方好友列表中发送方的id
						int uId = jsonObject.getJSONObject("mine").getInt("id");//对方用户id
						Map<String,Object> mineGroupMap = friendService.getMineGroup(uId,groupId);
						if(mineGroupMap != null && mineGroupMap.get("remark") != null && !"".equals(mineGroupMap.get("remark").toString())){
							toMessage.put("username",mineGroupMap.get("remark").toString());
						}
						/***查询群备注名称end，如果聊天框内不需要显示备注（只显示用户昵称）可以注释掉这段毕竟每次发送查询耗时***/
    		   				JSONArray memberList=JSONArray.fromObject(qunWS.getSimpleMemberByGroupId(toId));  //获取群成员userId列表
    		   				if(memberList.size()>0){              
    		   					for(int i=0;i<memberList.size();i++){                            //发送到在线用户(除了发送者)
    		   						if(mapUS.containsKey(memberList.get(i)) && !memberList.get(i).equals(jsonObject.getJSONObject("mine").getInt("id")+"")){
    		   						  session=mapUS.get(memberList.get(i));
    								  session.getAsyncRemote().sendText(toMessage.toString());
    								  logger.info("群聊-来自客户端的消息:" + toMessage.toString());
    		   						}else if(memberList.get(i).equals(jsonObject.getJSONObject("mine").getInt("id")+"")){
    		   							      	 //如果是发送者自己，不做任何操作。
    		   						}else{    	//如果是离线用户,数据存到redis待用户上线后推送。
    		   						   RedisUtils.lpush(memberList.get(i) + "_msg", toMessage.toString());
    		   						}
    		   					}
    		   				}
						//存入数据库，方便查询聊天记录
						int saveGroupMsgnum = messageService.saveGroupMessage(jsonObject);
    		   			break;
    		   		default:
    		   			break;
       		 }       
           }

    }  
  
    /** 
     * 发生错误时调用 
     * @param session 
     * @param error 
     */  
    @OnError  
    public void onError(Session session, Throwable error) {  
    	String userId=mapSU.get(session);
    	if(userId!=null&&userId!=""){
    	 	//更新redis中的用户在线状态
    		RedisUtils.set(userId+"_status","offline");
        	mapUS.remove(userId);
        	mapSU.remove(session);
			logger.info("用户"+userId+"退出llws！当前在线人数为" + mapUS.size());
    	}
		logger.error("llws发生错误!");
        error.printStackTrace();
    }  
    
    /** 
     * 这个方法与上面几个方法不一样。没有用注解，是根据自己需要添加的方法。 
     */  
    public void sendMessage(Session session,String message) {  
           session.getAsyncRemote().sendText(message);  
    }  
	
}
