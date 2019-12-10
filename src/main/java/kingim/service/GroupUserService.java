package kingim.service;

import java.util.List;
import java.util.Map;

import kingim.model.Group;
import kingim.model.GroupUser;
import kingim.vo.SNSUser;

public interface GroupUserService extends BaseService<GroupUser> {

	List<String> getSimpleMemberByGroupId(int groupId);

	// 根据用户id查询用户已加入的群组
	List<Group> getByUserId(int userId);
	
	// 根据群组id查询群组成员列表
	List<GroupUser> getByGroupIdList(int groupId);

	/**
	 * 批量添加群成员<br>
	 * 会忽略已是群组成员的用户
	 * @param guserList
	 *            群成员list(必选值userId,groupId；可选值remarkName)
	 * @return 受影响行数
	 */
	int batchSave(List<GroupUser> guserList);

	/**
	 * 清空群成员
	 * @param groupId
	 *            群组id
	 * @return 受影响行数
	 */
	int deleteByGroupId(int groupId);

	/**
	 * 是否还有群组成员
	 * @param groupId
	 *            群组id
	 * @return true:有，false:无
	 */
	boolean hasUser(int groupId);
	
	/**
	 * 获取群成员列表<br>
	 * 群组信息、用户登录信息和用户基本信息
	 * @param groupId
	 *            群组id
	 * @return 群成员列表
	 */
	List<SNSUser> getByGroupId(int groupId);
	
	//获取可添加到讨论组的好友列表
	List<GroupUser> getNewMemberByGroupId(int groupId,int userId);

	/**
	 * 群聊面板查看成员列表
	 * @param id
	 * @return
	 */
	List<SNSUser> getMemberByGroupId(int id);
	
	int deleteGroupUser(Map<String,Object> params);
	
	int addGroupUser(Map<String,Object> params);
	
	int deleteGroupUserById(Map<String,Object> params);
	
	int updateGroupRemark(Map<String,Object> params);
}
