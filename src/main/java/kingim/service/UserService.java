package kingim.service;

import kingim.model.User;
import kingim.utils.ZtreeNode;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface UserService {
	 
	  User getUserById(int userId);

	  User matchUser(String userName,String password);

	/**
	 * 根据中户id修改签名
	 * @param userId
	 * @param sign
	 * @return
	 */
      int updateUserSign(int userId, String sign);

	/**
	 * 上传头像
	 * @param imageName
	 * @param userId
	 * @return
	 */
	Map<String,Object> uploadAvatar(MultipartFile imageName,String realPath, int userId);
	/**
	 * 分页数据
	 * @return
	 */
	List<User> findUserList(Map<String,Object> params);
	
	/**
	 * 
	 */
	List<ZtreeNode> findOrgUnitList(Map<String,Object> map);
	/**
	 * 查询用户是否存在群组中
	 * @param map
	 * @return
	 */
	List<Map<String,Object>> finduserIsexistGroup(Map<String,Object> map);

	int saveUser(User user);
}
