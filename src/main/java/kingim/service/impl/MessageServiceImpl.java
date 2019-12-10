package kingim.service.impl;

import kingim.dao.MessageMapper;
import kingim.service.MessageService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 消息service
 * Created by sxf on 2019-11-26.
 */
@Service
public class MessageServiceImpl implements MessageService {
    @Autowired
    private MessageMapper messageMapper;
    @Override
    public int saveFriendMessage(JSONObject jsonObject) {
        Map<String,Object> paramsMap = new HashMap<String,Object>();
        paramsMap.put("fromId",jsonObject.getJSONObject("mine").getString("id"));
        paramsMap.put("toId",jsonObject.getJSONObject("to").getString("id"));
        paramsMap.put("content",jsonObject.getJSONObject("mine").getString("content"));
        return messageMapper.saveFriendMessage(paramsMap);
    }

    @Override
    public int saveGroupMessage(JSONObject jsonObject) {
        Map<String,Object> paramsMap = new HashMap<String,Object>();
        paramsMap.put("fromId",jsonObject.getJSONObject("mine").getString("id"));
        paramsMap.put("groupId",jsonObject.getJSONObject("to").getString("id"));
        paramsMap.put("content",jsonObject.getJSONObject("mine").getString("content"));
        return messageMapper.saveGroupMessage(paramsMap);
    }

    @Override
    public int getFriendMsgTotal(Map<String, Object> paramMap) {
        return messageMapper.getFriendMsgTotal(paramMap);
    }

    @Override
    public int getGroupMsgTotal(Map<String, Object> paramMap) {
        return messageMapper.getGroupMsgTotal(paramMap);
    }

    @Override
    public List<Map<String, Object>> getFriendMsgHis(Map<String, Object> paramMap) {
        List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
        int cur = paramMap.get("cur") == null ? 1 : Integer.parseInt(paramMap.get("cur").toString());
        int pageSize = paramMap.get("pageSize") == null ? 10 : Integer.parseInt(paramMap.get("pageSize").toString());
        paramMap.put("pageSize",pageSize);
        int stratRow = (cur -1)*pageSize;
        paramMap.put("stratRow",stratRow);
        returnList = messageMapper.getFriendMsgHis(paramMap);
        if(returnList != null && returnList.size() > 0){
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            for (Map<String, Object> map : returnList) {
                String sendtimeStr = map.get("send_time").toString().substring(0,19);
                try{
                    map.put("timestamp",format.parse(sendtimeStr).getTime());
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        Collections.sort(returnList,new Comparator<Map<String, Object>>() {
            public int compare(Map<String, Object> m1, Map<String, Object> m2) {
                long timestamp1= Long.parseLong(m1.get("timestamp").toString());
                long timestamp2= Long.parseLong(m2.get("timestamp").toString());
                if(timestamp1<timestamp2){
                    return -1;
                }
                return 1;
            }
        });
        return returnList;
    }

    @Override
    public List<Map<String, Object>> getGroupMsgHis(Map<String, Object> paramMap) {
        List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
        int cur = paramMap.get("cur") == null ? 1 : Integer.parseInt(paramMap.get("cur").toString());
        int pageSize = paramMap.get("pageSize") == null ? 10 : Integer.parseInt(paramMap.get("pageSize").toString());
        paramMap.put("pageSize",pageSize);
        int stratRow = (cur -1)*pageSize;
        paramMap.put("stratRow",stratRow);
        returnList = messageMapper.getGroupMsgHis(paramMap);
        if(returnList != null && returnList.size() > 0){
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            for (Map<String, Object> map : returnList) {
                String sendtimeStr = map.get("send_time").toString().substring(0,19);
                try{
                    map.put("timestamp",format.parse(sendtimeStr).getTime());
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
        }
        Collections.sort(returnList,new Comparator<Map<String, Object>>() {
            public int compare(Map<String, Object> m1, Map<String, Object> m2) {
                long timestamp1= Long.parseLong(m1.get("timestamp").toString());
                long timestamp2= Long.parseLong(m2.get("timestamp").toString());
                if(timestamp1<timestamp2){
                    return -1;
                }
                return 1;
            }
        });
        return returnList;
    }
}
