package kingim.service.impl;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kingim.dao.UserMapper;
import kingim.model.User;
import kingim.service.UserService;
import kingim.utils.ZtreeNode;

import org.springframework.web.multipart.MultipartFile;
import tk.mybatis.mapper.common.Mapper;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl  extends BaseServiceImpl<User> implements UserService{
	 @Autowired
     private UserMapper userMapper;

     @Override
     public Mapper<User> getMapper() {
        return userMapper;
     }

     public User getUserById(int userId) {  
        return userMapper.selectByPrimaryKey(userId);  
     }  
     
     public User matchUser(String userName,String password) {
    	 User record=new User();
    	 record.setUserName(userName);
    	 record.setPassword(password);
         return userMapper.selectOne(record);
     }

    @Override
    public int updateUserSign(int userId, String sign) {
        User user = new User();
        user.setId(userId);
        user.setSign(sign);
        return userMapper.updateUserSign(user);
    }

    @Override
    public Map<String, Object> uploadAvatar(MultipartFile imgFile,String realPath, int userId) {
         Map<String,Object> resultMap = new HashMap<String,Object>();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        SimpleDateFormat formatDay = new SimpleDateFormat("yyyyMMdd");
        Date nowdate = new Date();
        //生成文件名字
        String name =format.format(nowdate) +"."+ imgFile.getOriginalFilename().split("\\.")[1];
        String savePath = "images"+File.separator+"avatar"+File.separator+formatDay.format(nowdate);
        File filePath = new File(realPath+savePath);
        if(!filePath.exists()){
            filePath.mkdirs();
        }
        //拼接保存到银硬盘的地址目录
        String imageSaveFile = realPath+savePath+ File.separator + name;
        //写入硬盘保存
        try{
            FileUtils.writeByteArrayToFile(new File(imageSaveFile), imgFile.getBytes());
            resultMap.put("code",0);
            resultMap.put("msg",File.separator+savePath+ File.separator + name);
            User user = new User();
            user.setId(userId);
            user.setAvatar(resultMap.get("msg").toString());
            userMapper.uploadAvatar(user);
        }catch (Exception e){
            e.printStackTrace();
            resultMap.put("code",1);
            resultMap.put("msg","头像上传失败！");
        }

        return resultMap;
    }

	@Override
	public List<User> findUserList(Map<String,Object> params) {
		return userMapper.findUserList(params);
	}

	@Override
	public List<ZtreeNode> findOrgUnitList(Map<String, Object> map) {
		return userMapper.findOrgUnitList(map);
	}

	@Override
	public List<Map<String, Object>> finduserIsexistGroup(Map<String, Object> map) {
		return userMapper.finduserIsexistGroup(map);
	}

    @Override
    public int saveUser(User user) {
        String avatar = user.getAvatar();
        if(user.getAvatar() != null && !user.getAvatar().trim().equals("")){
        }else{
            if(user.getGender() == 0){
                user.setAvatar("/images/boy-01.png");
            }else{
                user.setAvatar("/images/girl-01.png");
            }
        }
        return save(user);
    }
}
