package kingim.service.impl;

import com.github.pagehelper.PageInfo;

import kingim.dao.GroupMapper;
import kingim.model.Group;
import kingim.model.User;
import kingim.service.GroupService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.common.Mapper;
import java.util.List;
import java.util.Map;


/**
 * 群组Service
 * @author 1540247870@qq.com
 */
@Service
public class GroupServiceImpl extends BaseServiceImpl<Group> implements GroupService{

    @Autowired
    private GroupMapper groupMapper;

    @Override
    public Mapper<Group> getMapper() {
        return groupMapper;
    }

    @Override
    public PageInfo<Group> search(String searchStr, int groupTypeId, int pageNum, int pageSize) {
        return null;
    }

    @Override
    public User getGroupMaster(int groupId) {
        return null;
    }

//    @Override
//    public int save(Group group) {
//        return 0;
//    }

    @Override
    public int deleteById(Object id) {
        return 0;
    }

    @Override
    public int update(Group group) {
        return 0;
    }

    @Override
    public List<Group> selectAll() {
        return null;
    }

    @Override
    public Group getById(Object id) {
        return null;
    }

    @Override
    public Group selectOne(Group group) {
        return null;
    }

    @Override
    public Group findByProperty(String propertyName, Object value) {
        return null;
    }

    @Override
    public List<Group> findListByProperty(String propertyName, Object value) {
        return null;
    }

    @Override
    public List<Group> select(Group group) {
        return null;
    }

    @Override
    public List<Group> selectAndPaging(Group group, Integer pageNum, Integer pageSize) {
        return null;
    }

    @Override
    public PageInfo<Group> selectAndPagingAndPackage(Group group, Integer pageNum, Integer pageSize) {
        return null;
    }

	@Override
	public List<Group> getByUserId(int userId) {
		return groupMapper.findGroupByUserId(userId);
	}

	@Override
	public int addGroup(Map<String, Object> params) {
		return groupMapper.addGroup(params);
	}

	@Override
	public Group findGroupById(int groupId) {
		return groupMapper.findGroupById(groupId);
	}

	@Override
	public int updateGroup(Map<String, Object> params) {
		return groupMapper.updateGroup(params);
	}

	@Override
	public int deleteGroup(Map<String, Object> params) {
		return groupMapper.delGroup(params);
	}
}
