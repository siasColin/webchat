package kingim.service.impl;

import java.util.List;
import java.util.Map;

import kingim.dao.GroupMapper;
import kingim.dao.GroupUserMapper;
import kingim.dao.UserMapper;
import kingim.model.Group;
import kingim.model.GroupUser;
import kingim.service.GroupUserService;
import kingim.vo.SNSUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.common.Mapper;

/**
 * 群成员
 * @author 1540247870@qq.com
 */
@Service
public class GroupUserServiceImpl extends BaseServiceImpl<GroupUser> implements GroupUserService {

	@Autowired
	GroupUserMapper groupUserMapper;
	@Autowired
	GroupMapper groupMapper;
	@Autowired
	private UserMapper userMapper;

	@Override
	public Mapper<GroupUser> getMapper() {
		return groupUserMapper;
	}

	@Override
	public List<String> getSimpleMemberByGroupId(int groupId) {
		return groupUserMapper.getSimpleMemberByGroupId(groupId);
	}

	@Override
	public List<Group> getByUserId(int userId) {
		return groupMapper.getByUserId(userId);
	}

	@Override
	public int batchSave(List<GroupUser> guserList) {
		return 0;
	}

	@Override
	public int deleteByGroupId(int groupId) {
		return 0;
	}

	@Override
	public boolean hasUser(int groupId) {
		return false;
	}

	@Override
	public List<SNSUser>  getByGroupId(int groupId) {
		return groupUserMapper.getMemberByGroupId(groupId);
	}

	@Override
	public List<GroupUser> getNewMemberByGroupId(int groupId, int userId) {
		return null;
	}

	@Override
	public List<SNSUser> getMemberByGroupId(int id) {
		return groupUserMapper.getMemberByGroupId(id);
	}

	

	@Override
	public int deleteGroupUser(java.util.Map<String, Object> params) {
		return groupUserMapper.deleteGroupUser(params);
	}

	@Override
	public List<GroupUser> getByGroupIdList(int groupId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int addGroupUser(Map<String, Object> params) {
		SNSUser snsUser = userMapper.findSNSUserByUserID(Integer.parseInt(params.get("userId")+""));
		params.put("remark", snsUser.getUsername());
		return groupUserMapper.addGroupUser(params);
	}

	@Override
	public int deleteGroupUserById(Map<String, Object> params) {
		return groupUserMapper.deleteGroupUserById(params);
	}

	@Override
	public int updateGroupRemark(Map<String, Object> params) {
		return groupUserMapper.updateGroupRemark(params);
	}


}
