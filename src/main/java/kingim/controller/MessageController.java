package kingim.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import kingim.service.FriendService;
import kingim.service.MessageService;
import kingim.utils.RedisUtils;
import kingim.vo.SNSMessage;
import kingim.vo.SNSMessageInit;
import kingim.vo.SNSUser;
import kingim.ws.LLWS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Autowired
    MessageService messageService;

    @RequestMapping("/applyAddFriend")
    public void applyAddFriend(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println(111);
    }
    @RequestMapping(value = "systemMsgNum", produces = "application/json; charset=utf-8")
    public @ResponseBody JSONObject systemMsgNum(int userId) {
        JSONObject sysMessage=new JSONObject();
        sysMessage.put("type","system");
        if(RedisUtils.exists(userId + "_msgBox")){
            Long len = RedisUtils.llen(userId + "_msgBox");
            sysMessage.put("num",len);
        }else{
            sysMessage.put("num",0);
        }
        return sysMessage;
    }
    @RequestMapping(value = "systemMsg", produces = "application/json; charset=utf-8")
    public @ResponseBody SNSMessageInit systemMsg(int page,int userID) {
        SNSMessageInit messageInit = new SNSMessageInit();
        List<SNSMessage> messageList = new ArrayList<SNSMessage>();
        Long len = RedisUtils.llen(userID + "_msgBox");
        if(len % 5 == 0l){
            messageInit.setPages(new Long(len/5).intValue());
        }else{
            messageInit.setPages(new Long(len/5).intValue()+1);
        }
        if(len > 0){
            int getnum = len > 4 ? 5 : len.intValue();
            for (int i = 0; i < getnum;i++){//分页，每次取5条消息
                try{
                    String snsMessageStr = RedisUtils.lpop(userID + "_msgBox").toString();//先取最新的消息
                    JSONObject snsMessageJson = JSONObject.parseObject(snsMessageStr);
                    SNSMessage snsMessage = JSON.toJavaObject(snsMessageJson,SNSMessage.class);
                    messageList.add(snsMessage);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        messageInit.setData(messageList);
        return messageInit;
    }

    @RequestMapping(value = "msghis", produces = "application/json; charset=utf-8")
    public @ResponseBody Object msghis(@RequestParam Map<String, Object> paramMap) {
        JSONObject returnObj =new JSONObject();
        returnObj.put("code",1);
        returnObj.put("msg","获取聊天记录失败");
        if(paramMap.get("type") != null && paramMap.get("type").toString().trim().equals("friend")){
            List<Map<String,Object>> msgList = messageService.getFriendMsgHis(paramMap);
            returnObj.put("data",msgList);
        }else if(paramMap.get("type") != null && paramMap.get("type").toString().trim().equals("group")){
            List<Map<String,Object>> msgList = messageService.getGroupMsgHis(paramMap);
            returnObj.put("data",msgList);
        }
        returnObj.put("code",0);
        returnObj.put("msg","");
        return returnObj;
    }

    @RequestMapping(value = "getMsgTotal", produces = "application/json; charset=utf-8")
    public @ResponseBody Object getMsgTotal(@RequestParam Map<String, Object> paramMap) {
        JSONObject returnObj =new JSONObject();
        returnObj.put("code",1);
        returnObj.put("msg","获取聊天记录失败");
        if(paramMap.get("type") != null && paramMap.get("type").toString().trim().equals("friend")){
            int total = messageService.getFriendMsgTotal(paramMap);
            returnObj.put("total",total);
        }else if(paramMap.get("type") != null && paramMap.get("type").toString().trim().equals("group")){
            int total = messageService.getGroupMsgTotal(paramMap);
            returnObj.put("total",total);
        }

        returnObj.put("code",0);
        returnObj.put("msg","");
        return returnObj;
    }

}