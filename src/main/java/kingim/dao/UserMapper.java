package kingim.dao;

import java.util.List;
import java.util.Map;

import kingim.model.User;
import kingim.utils.ZtreeNode;
import kingim.vo.SNSUser;
import tk.mybatis.mapper.common.Mapper;

public interface UserMapper extends Mapper<User> {

    SNSUser findSNSUserByUserID(int userID);

    int updateUserSign(User user);

    void uploadAvatar(User user);
    
    List<User> findUserList(Map<String,Object> params);
    
    List<ZtreeNode> findOrgUnitList(Map<String,Object> map);
    
    List<Map<String,Object>> finduserIsexistGroup(Map<String,Object> params);
    
    int addUser(Map<String,Object> params);
}