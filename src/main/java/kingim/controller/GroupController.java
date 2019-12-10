package kingim.controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

import kingim.model.Group;
import kingim.model.GroupUser;
import kingim.service.GroupService;
import kingim.service.GroupUserService;
import kingim.service.UserService;
import kingim.utils.JsonResult;
import kingim.utils.LayUIJson;
import kingim.vo.SNSMData;
import kingim.vo.SNSMember;
import kingim.vo.SNSUser;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by sxf on 2019-11-22.
 */
@Controller
@RequestMapping("/group")
public class GroupController {
    @Autowired
    UserService userService;
    @Autowired
    private GroupUserService groupUserService;
    @Autowired
    private GroupService groupService;

    @RequestMapping(value = "getMemberByGroupId", produces = "text/plain; charset=utf-8")
    public @ResponseBody String getMemberByGroupId(int id) {
        SNSMember snsMember = new SNSMember();
        SNSMData snsmData = new SNSMData();
        List<SNSUser> snsUserList = groupUserService.getMemberByGroupId(id);
        if(snsUserList != null && snsUserList.size() > 0){
            snsmData.setList(snsUserList);
        }
        snsMember.setData(snsmData);
        return JSON.toJSONString(snsMember);
    }
    
    @RequestMapping("/groupPage")
    public String groupPage(HttpServletRequest request){
    	String userId = request.getParameter("userId");
    	 List<Group> listgroup = groupService.getByUserId(Integer.parseInt(userId));
    	 request.setAttribute("listgroup", listgroup);
    	 if(listgroup != null && listgroup.size() > 0){
    		 request.setAttribute("groupId", listgroup.get(0).getId());
    	 }
    	 if(listgroup != null && listgroup.size() >0){
    		 List<SNSUser> listuser = groupUserService.getByGroupId(listgroup.get(0).getId());
    		 request.setAttribute("userCount", listuser.size());
    	 }else{
    		 request.setAttribute("userCount", 0);
    	 }
    	 
         return "management";
    }
    
    @ResponseBody
	@RequestMapping("/queryGroupUserByList")
	public LayUIJson queryGroupUserByList(HttpServletRequest request,String groupId) throws Exception {
    	LayUIJson json = new LayUIJson();
		Integer pageNum = 1;
		Integer pageSize = 12;
		List<SNSUser> mList = null;
		try {
			String groupIdd = request.getParameter("groupId")==null?"":request.getParameter("groupId");
			pageNum = Integer.parseInt(request.getParameter("page"));
			pageSize = Integer.parseInt(request.getParameter("limit"));
			PageHelper.startPage(pageNum, pageSize, true);
			mList = groupUserService.getByGroupId(Integer.parseInt(groupIdd));
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(mList != null && mList.size() > 0){
			json.setCode(0);
			json.setData(mList);
			json.setCount(((Page)mList).getTotal());
		}else{
			json.setCode(0);
			json.setData(null);
			json.setCount(0);
		}
		
		return json;
	}
    
    
    
    @RequestMapping("/addGroupPage")
    public String addGroupPage(HttpServletRequest request){
        if(request.getParameter("userId") != null){
            request.setAttribute("userId",request.getParameter("userId").toString());
        }
        return "groupAdd";
    }
    
    @RequestMapping(value = "addGroup",produces = "application/json; charset=utf-8")
    public @ResponseBody JSONObject addGroup(HttpServletRequest request) {
        JSONObject returnObj = new JSONObject();
        Map<String,Object> params = new HashMap<String, Object>();
        String groupName = request.getParameter("groupName");
        String groupNum = request.getParameter("groupNum");
        String userId = request.getParameter("userId");
        String description = request.getParameter("description");
        String avatar = request.getParameter("avatar");
        params.put("groupName", groupName);
        params.put("groupNum", groupNum);
        params.put("description", description);
        params.put("userId", userId);
        params.put("avatar", avatar);
        int savenum = groupService.addGroup(params);
        if(savenum > 0){
            returnObj.put("code","0");
            returnObj.put("id", params.get("id"));
            returnObj.put("msg","添加群组成功");
        }else{
            returnObj.put("code","1");
            returnObj.put("msg","添加群组失败");
        }
        return returnObj;
    }
    
    @RequestMapping("/updateGroupPage")
    public String updateGroupPage(HttpServletRequest request){
    	String groupId = request.getParameter("groupId");
    	Group group = groupService.findGroupById(Integer.parseInt(groupId));
        request.setAttribute("group",group);
        return "groupUpdate";
    }
    
    
    @RequestMapping(value = "updateGroup",produces = "application/json; charset=utf-8")
    public @ResponseBody JSONObject updateGroup(HttpServletRequest request) {
        JSONObject returnObj = new JSONObject();
        Map<String,Object> params = new HashMap<String, Object>();
        String groupName = request.getParameter("groupName");
        String groupNum = request.getParameter("groupNum");
        String description = request.getParameter("description");
        String avatar = request.getParameter("avatar");
        String id = request.getParameter("id");
        params.put("groupName", groupName);
        params.put("groupNum", groupNum);
        params.put("description", description);
        params.put("avatar", avatar);
        params.put("id", id);
        int savenum = groupService.updateGroup(params);
        if(savenum > 0){
            returnObj.put("code","0");
            returnObj.put("msg","更新群组成功");
        }else{
            returnObj.put("code","1");
            returnObj.put("msg","更新群组失败");
        }
        return returnObj;
    }
    
    
    @RequestMapping(value = "delGroup",produces = "application/json; charset=utf-8")
    public @ResponseBody JSONObject delGroup(HttpServletRequest request) {
        JSONObject returnObj = new JSONObject();
        Map<String,Object> params = new HashMap<String, Object>();
        String id = request.getParameter("id");
        params.put("id", id);
        int savenum = groupService.deleteGroup(params);
        groupUserService.deleteGroupUser(params);
        if(savenum > 0){
            returnObj.put("code","0");
            returnObj.put("id", params.get("id"));
            returnObj.put("msg","删除群组成功");
        }else{
            returnObj.put("code","1");
            returnObj.put("msg","删除群组失败");
        }
        return returnObj;
    }
    
    @RequestMapping(value = "delGroupUserById",produces = "application/json; charset=utf-8")
    public @ResponseBody JSONObject delGroupUserById(HttpServletRequest request) {
        JSONObject returnObj = new JSONObject();
        Map<String,Object> params = new HashMap<String, Object>();
        String id = request.getParameter("id");
        params.put("id", id);
        int savenum = groupUserService.deleteGroupUserById(params);
        if(savenum > 0){
            returnObj.put("code","0");
            returnObj.put("id", params.get("id"));
            returnObj.put("msg","移除用户成功");
        }else{
            returnObj.put("code","1");
            returnObj.put("msg","移除用户失败");
        }
        return returnObj;
    }
    
    @RequestMapping(value = "updateGroupRemark",produces = "application/json; charset=utf-8")
    public @ResponseBody Object updateGroupRemark(String id,String remark) {
        Map<String,Object> returnMap = new HashMap<String,Object>();
        returnMap.put("code",-1);
        returnMap.put("msg","更新备注失败！");
        Map<String,Object> params = new HashMap<String,Object>();
        params.put("id", id);
        params.put("remark", remark);
        int updateNum = groupUserService.updateGroupRemark(params);
        if(updateNum > 0){
        	returnMap.put("code",0);
            returnMap.put("msg","");
        }
        
        return returnMap;
    }
}
