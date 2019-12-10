package kingim.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.github.pagehelper.PageInfo;
import kingim.dao.FriendTypeMapper;
import kingim.model.Friend;
import kingim.model.FriendType;
import kingim.model.User;
import kingim.service.FriendTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.common.Mapper;


/**
 * 好友分组
 */
@Service
public class FriendTypeServiceImpl extends BaseServiceImpl<FriendType> implements FriendTypeService {

	@Autowired
	private FriendTypeMapper friendTypeMapper;

	@Override
	public Mapper<FriendType> getMapper() {
		return friendTypeMapper;
	}

	@Override
	public List<FriendType> getFriendTypeByUserId(int userId) {
		return friendTypeMapper.getFriendTypeByUserId(userId);
	}

	@Override
	public List<FriendType> getFriendCountByUserId(int userId) {
		return null;
	}

	@Override
	public long getOnlineCountByTypeId(int id) {
		return 0;
	}

	@Override
	public PageInfo<User> getFriendByTypeIdPage(int id, int pageNum, int pageSize) {
		return null;
	}

	@Override
	public List<User> getFriendByTypeId(int id) {
		return null;
	}

	@Override
	public List<FriendType> getFriendByUserId(int userId) {
		return null;
	}

	@Override
	public int getByUserId(int userId) {
		return 0;
	}

	@Override
	public FriendType getByUserIdTypeName(int userId, String typeName) {
		return null;
	}

	@Override
	public int updateBatchToOtherType(List<Friend> friendList, int toTypeId) {
		return 0;
	}

	@Override
	public int updateToOtherType(int userId, int friendId, int toTypeId) {
		return 0;
	}

	@Override
	public List<FriendType> getFriendTypeList(int userId) {
		return null;
	}

	@Override
	public List<FriendType> searchMyFriendGroupByType(Integer userId, String searchStr) {
		return null;
	}

	@Override
	public int delById(Map<String,Object> params) {
		return friendTypeMapper.deleteFriendTypeById(params);
	}

	@Override
	public FriendType addFriendType(int userId, String groupName,int is_default) {
		FriendType friendType = new FriendType();
		friendType.setUserId(userId);
		friendType.setTypeName(groupName);
		friendType.setIsDefault(is_default);
		friendTypeMapper.addFriendType(friendType);
		return friendType;
	}

	@Override
	public FriendType findFriendTypeById(Map<String, Object> params) {
		return friendTypeMapper.findFriendTypeById(params);
	}

	@Override
	public int updateFriendTypeName(Map<String, Object> params) {
		return friendTypeMapper.updateFriendTypeName(params);
	}


}
