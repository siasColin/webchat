package kingim.service;

import net.sf.json.JSONObject;

import java.util.List;
import java.util.Map;

/**
 * Created by sxf on 2019-11-26.
 */
public interface MessageService {
    /**
     * 保存好友消息到数据库
     * @param jsonObject
     * @return
     */
    int saveFriendMessage(JSONObject jsonObject);

    /**
     * 保存群消息到数据库
     * @param jsonObject
     * @return
     */
    int saveGroupMessage(JSONObject jsonObject);

    /**
     * 查询好友历史聊天记录总数
     * @param paramMap
     * @return
     */
    int getFriendMsgTotal(Map<String, Object> paramMap);
    /**
     * 查询群历史聊天记录总数
     * @param paramMap
     * @return
     */
    int getGroupMsgTotal(Map<String, Object> paramMap);

    /**
     * 查询好友历史聊天记录
     * @param paramMap
     * @return
     */
    List<Map<String,Object>> getFriendMsgHis(Map<String, Object> paramMap);

    /**
     * 查询群历史聊天记录
     * @param paramMap
     * @return
     */
    List<Map<String,Object>> getGroupMsgHis(Map<String, Object> paramMap);
}
