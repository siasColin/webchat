package kingim.service;

import java.util.List;
import java.util.Map;

import kingim.model.Friend;
import kingim.model.User;

public interface FriendService extends BaseService<Friend> {

	List<User> searchFriendByFriendId(int friendId);

	List<User> searchFriendByRemarkName(String remarkName);

	/**
	 * 是否已是好友关系
	 * 
	 * @param userId
	 *            用户id
	 * @param friendId
	 *            好友id
	 * @return true:已是好友 false不是好友
	 */
	boolean isFriend(int userId, int friendId);

	/**
	 * 删除好友
	 * 
	 * @param userId
	 *            用户id
	 * @param friendId
	 *            好友id
	 * @return true:已是好友 false不是好友
	 */

	int delFriend(int userId, int friendId);

	/**
	 * 添加好友关系,双向保存、放到一个事务中，确保都成功或者都失败
	 *
	 * @param fromId 添加者的用户id
	 * @param toId	被添加者的用户id
	 * @param from_group 添加者设置的所属分组id
	 * @param group 呗添加者设置的所属分组id
	 * @return
	 */
	int addFriend(int fromId, int toId, int from_group,int group);

	/**
	 * @param userId
	 * @return int:好友数
	 */
	int getFriendCounts(int userId);

	/**
	 * 根据userId查询好友id
	 * 
	 * @param userId
	 * @return List<String>
	 */
	List<String> getFriendsId(int userId);

	/**
	 * 发送添加好友申请
	 * @param from 申请方用户id
	 * @param from_group 申请方设置的分组id
	 * @param uid 被申请方用户id
	 * @param remark 验证信息
	 */
	void sendAddFriend(int from, int uid, int from_group,String remark);

	/**
	 * 查询好友信息
	 * @param userId
	 * @param friendId
	 * @return
	 */
    Map<String,Object> getFriend(int userId, int friendId);

	/**
	 * 查询用户在群中的信息
	 * @param uId
	 * @param groupId
	 * @return
	 */
	Map<String,Object> getMineGroup(int uId, int groupId);

	/**
	 * 查询用户所有分组，并统计每个分组下好友个数
	 * @param userId
	 * @return
	 */
	List<Map<String,Object>> friendTypeCount(int userId);

	/**
	 *
	 * @param typeId
	 * @return
	 */
	List<Map<String,Object>> getFriendByTypeId(int typeId,int userId);

	/**
	 * 移动好友至某个分组
	 * @param typeId
	 * @param friendId
	 * @return
	 */
    int updateFriendType(int typeId, int friendId);
    
    /**
	 * 更新备注
	 * @param typeId
	 * @param friendId
	 * @return
	 */
    int updateRemark(Map<String,Object> params);
    
    /**
	 * 删除好友
	 * @param typeId
	 * @param friendId
	 * @return
	 */
    int deleteFriendById(Map<String,Object> params);
    
    
    int delFriendByFriendId(Map<String,Object> params);
    
    
    int syncUser(Map<String,Object> params);
}
