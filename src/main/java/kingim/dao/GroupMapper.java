package kingim.dao;

import kingim.model.Group;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;

public interface GroupMapper extends Mapper<Group> {
    // 获取群组列表
    List<Group> getByUserId(int userId);
    
    
    List<Group> findGroupByUserId(int userId);
    
    
    int addGroup(Map<String,Object> params);
    
    
    Group findGroupById(int id);
    
    int updateGroup(Map<String,Object> params);
    
    int delGroup(Map<String,Object> params);
}