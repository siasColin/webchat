package kingim.dao;

import java.util.List;
import java.util.Map;

/**
 * Created by sxf on 2019-11-26.
 */
public interface MessageMapper {
    int saveFriendMessage(Map<String, Object> paramsMap);

    int saveGroupMessage(Map<String, Object> paramsMap);

    int getFriendMsgTotal(Map<String, Object> paramMap);

    int getGroupMsgTotal(Map<String, Object> paramMap);

    List<Map<String,Object>> getFriendMsgHis(Map<String, Object> paramMap);

    List<Map<String,Object>> getGroupMsgHis(Map<String, Object> paramMap);
}
