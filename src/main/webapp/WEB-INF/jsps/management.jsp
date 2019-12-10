<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<title>friend</title>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/layim/css/layui.css" media="all"/>
<link rel="stylesheet" href="/css/management.css">
<style>
.layui-btn+.layui-btn {
    margin-left: auto !important;
}
</style>
</head>
<body>
    <div class="main">
            <div class="layui-row" style="height:100%;">
                <div class="layui-col-sm10 layui-col-sm-offset1" style="height:100%;background: #fff;">
                    <div class="layui-col-sm3" style="height:100%;">
                        <ul class="GroupAdministration" id="groupList">
                            <c:if test="${not empty listgroup}">
                                <c:forEach items="${listgroup}" var="group" varStatus="status">
                                    <li data-id="${group.id}" id="liobj${group.id}" <c:if test="${status.index == 0}">class="li_active"</c:if> onclick="groupClick(this)">
		                                <div class="GroupName">
		                                    <p id="groupNameP${group.id}">${group.groupName}</p>
		                                    <p>简介:<i id="descriptionI${group.id}">${group.description}</i></p>
		                                </div>
		                                <i id="userCountHtml${group.id}">${group.usercount}</i>
		                            </li>
                                </c:forEach>
                            </c:if>
                        </ul>
                        <button class="addgroup layui-btn layui-btn-primary" onclick="addGroup();">新建群</button>
                    </div>
                    <div class="layui-col-sm9" style="height:100%;overflow: auto;">
                        <div class="layui-btn-group btn_box">
                            <input type="hidden" name="groupId" id="groupId" value="${groupId}"/>
                            <button type="button" class="layui-btn" onclick="updateGroup();">修改群信息</button>
                            <button type="button" class="layui-btn" onclick="userListPage();">添加群员</button>
                            <button type="button" class="layui-btn" onclick="deleteGroup();">解散群</button>
                        </div>
                        <ul class="FriendDetails" id="groupUserList">
                            <!-- <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p>Hi kingim</p>
                                    <button class="layui-btn layui-btn-primary layui-btn-sm">移除群</button>
                                </div>
                            </li>
                            <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p>Hi kingim</p>
                                    <button class="layui-btn layui-btn-primary layui-btn-sm">移除群</button>
                                </div>
                            </li>
                            <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p>Hi kingim</p>
                                    <button class="layui-btn layui-btn-primary layui-btn-sm">移除群</button>
                                </div>
                            </li> -->
                        </ul>
                        <div id="page" style="margin-right: 10px;float: right;"></div>
                    </div>
                </div>
            </div>
        </div>

<script src="/js/jquery.min.js"></script>
<script src="/layim/layui.all.js"></script>
<script>
    document.onselectstart = function () { return false; };
    $('.GroupAdministration').find('li').on('click',function(){
        $(this).addClass('li_active').siblings().removeClass('li_active')
    })
    var userCount = '${userCount}';
    var laypage;
    layui.use(['laypage', 'layer'], function(){
       	  laypage = layui.laypage
       	  ,layer = layui.layer;
       	  var groupId = $("#groupId").val();
       	  //总页数低于页码总数
       	  laypage.render({
       		   id: 'UserReload'
       	       ,elem: 'page'
       	       ,count: userCount //数据总数
       	       ,limit:12
       	       ,jump:function(obj,first){
       	    	   $.post('/group/queryGroupUserByList',{page:obj.curr,limit:obj.limit,groupId:groupId},
      	    			   function(result){
      	    		          if(result.data != null && result.data.length > 0){
      	    		        	  $("#groupUserList").find("li").remove();
	      	   		        	  var html = "";
	      	   		        	  for(var i=0;i<result.data.length;i++){
	      		   		        		html += '<li><div class="HeadPortrait" style="height: 95px;">'+
	      		                        '<img src="'+result.data[i].avatar+'" alt=""></div><div class="FriendInformation">'+
	      		                        '<p>'+result.data[i].username+'</p><p>备注：<i ondblclick="toReplace(this,'+result.data[i].groupUserId+')">'+result.data[i].remark+'</i></p><button class="layui-btn layui-btn-primary layui-btn-sm" onclick="deleteUser('+result.data[i].groupUserId+');">移除群</button>'+
	      		                        '</div></li>';
	      	   		        	  }
	      	   		        	  $("#groupUserList").append(html);
      	    		          }
       	    	   });
       	       }
       	  });
    })
    
    function groupClick(obj){
    	
        $(obj).addClass('li_active').siblings().removeClass('li_active');
        $("#groupId").val($(obj).attr("data-id"));
        var userCount = $("#userCountHtml"+$(obj).attr("data-id")).html();
        laypage.render({
    		   id: 'UserReload'
    	       ,elem: 'page'
    	       ,count: userCount //数据总数
    	       ,limit:12
    	       ,jump:function(obj,first){
    	    	   $.post('/group/queryGroupUserByList?groupId='+$("#groupId").val(),{page:obj.curr,limit:obj.limit},
   	    			   function(result){
   	    		          if(result.data != null && result.data.length > 0){
   	    		        	  $("#groupUserList").find("li").remove();
	      	   		        	  var html = "";
	      	   		        	  for(var i=0;i<result.data.length;i++){
	      		   		        		html += '<li><div class="HeadPortrait" style="height: 95px;">'+
	      		                        '<img src="'+result.data[i].avatar+'" alt=""></div><div class="FriendInformation">'+
	      		                        '<p>'+result.data[i].username+'</p><p>备注：<i ondblclick="toReplace(this,'+result.data[i].groupUserId+')">'+result.data[i].remark+'</i></p><button class="layui-btn layui-btn-primary layui-btn-sm" onclick="deleteUser('+result.data[i].groupUserId+');">移除群</button>'+
	      		                        '</div></li>';
	      	   		        	  }
	      	   		        	  $("#groupUserList").append(html);
   	    		          }else{
   	    		        	$("#groupUserList").find("li").remove();
   	    		        	  laypage.render({
   	    		        	    elem: 'page'
   	    		        	    ,count: 0 //数据总数
   	    		        	  })
   	    		          }
    	    	   });
    	       }
    	  });
        
        
        /* $.post('/group/queryGroupUserByList',{page:1,limit:12,"groupId":$(obj).attr("data-id")},
   			   function(result){
        	      //debugger;
   		          if(result.data != null && result.data.length > 0){
   		        	      var count = result.count;
  		       	    	  $("#groupUserList").find("li").remove();
    		        	  var html = "";
    		        	  for(var i=0;i<result.data.length;i++){
 	   		        		html += '<li><div class="HeadPortrait" style="height: 95px;">'+
 	                        '<img src="'+result.data[i].avatar+'" alt=""></div><div class="FriendInformation">'+
 	                        '<p>'+result.data[i].username+'</p><p>'+result.data[i].remark+'</p><button class="layui-btn layui-btn-primary layui-btn-sm">移除群</button>'+
 	                        '</div></li>';
    		        	  }
    		        	  $("#groupUserList").append(html);
    		        	  $("#page").show();
   		          }else{
   		        	    $("#groupUserList").find("li").remove();
   		        	    $("#page").hide();
	   		        	
   		          }
    	}); */
    }
    
    
    function addGroup(){
        layui.layer.open({
            title:"添加群组",
            type: 2,
            area: ['500px','400px'],
            offset: 't',
            btn: ['保存', '取消'],
            content: '/group/addGroupPage?userId='+$("#userId",window.parent.document).val(),
            yes: function(index,layero){
                // 获取iframe层的body
                var body = layer.getChildFrame('body', index);
                // 找到隐藏的提交按钮模拟点击提交
                body.find('#permissionSubmit').click();
            }
        });
    }
    
    function updateGroup(){
        layui.layer.open({
            title:"修改群组",
            type: 2,
            area: ['450px','300px'],
            btn: ['保存', '取消'],
            content: '/group/updateGroupPage?groupId='+$("#groupId").val(),
            yes: function(index,layero){
                // 获取iframe层的body
                var body = layer.getChildFrame('body', index);
                // 找到隐藏的提交按钮模拟点击提交
                body.find('#permissionSubmit').click();
            }
        });
    }
    
    
    
    function appendGroup(groupName,description,id){
    	var html = '<li data-id="'+id+'" id="liobj'+id+'" onclick="groupClick(this)">'+
                     '<div class="GroupName"><p id="groupNameP'+id+'">'+groupName+'</p><p>简介:<i id="descriptionI"'+id+'">'+description+'</i></p>'+
                     '</div><i id="userCountHtml${group.id}">0</i></li>';
    	$("#groupList").append(html);
    }
    
    function appendUpateGroup(groupName,description){
    	var groupId = $("#groupId").val();
    	$("#groupNameP"+groupId).html(groupName);
    	$("#descriptionI"+groupId).html(description);
    }
    
    
    function deleteGroup(){
    	var groupId = $("#groupId").val();
    	layer.confirm('你确定要删除选中的群组么?', {icon: 3, title:'提示'}, function(index){
			$.ajax({
                async:false,
                type: "POST",
                url: '/group/delGroup',
                data:{"id":groupId},
                dataType: "json",
                success: function(res){
                    //if(res.code != 0){
                         layui.layer.msg(res.msg);
                         $("#liobj"+groupId).remove();
                         return;
                    //}
                    //layui.layer.msg("移动好友成功，请刷新查看");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
		    layer.close(index);
		});
    }
    
    function deleteUser(id){
    	var groupId = $("#groupId").val();
    	layer.confirm('你确定要移除用户么?', {icon: 3, title:'提示'}, function(index){
			$.ajax({
                async:false,
                type: "POST",
                url: '/group/delGroupUserById',
                data:{"id":id},
                dataType: "json",
                success: function(res){
                    //if(res.code != 0){
                         layui.layer.msg(res.msg);
                         groupClick($("#liobj"+groupId));
                         delUserCount();
                         return;
                    //}
                    //layui.layer.msg("移动好友成功，请刷新查看");
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                }
            });
		    layer.close(index);
		});
    }
    
    function userListPage(){
        layui.layer.open({
            title:"用户列表",
            type: 2,
            area: ['750px','600px'],
            btn: ['取消'],
            content: '/index/userListPage?groupId='+$("#groupId").val(),
            yes: function(index,layero){
                // 获取iframe层的body
                var body = layer.getChildFrame('body', index);
                
            }
        });
    }
    
    function updateUserCount(){
    	var groupId = $("#groupId").val();
    	var count = $("#userCountHtml"+groupId).html();
    	var newcount = parseInt(count) + 1;
    	groupClick($("#liobj"+groupId));
    	$("#userCountHtml"+groupId).html(newcount);
    }
    
    
    function updateUserSzie(num){
    	var groupId = $("#groupId").val();
    	var count = $("#userCountHtml"+groupId).html();
    	var newcount = parseInt(count) + parseInt(num);
    	groupClick($("#liobj"+groupId));
    	$("#userCountHtml"+groupId).html(newcount);
    }
    
    function delUserCount(){
    	var groupId = $("#groupId").val();
    	var count = $("#userCountHtml"+groupId).html();
    	var newcount = parseInt(count) - 1;
    	$("#userCountHtml"+groupId).html(newcount);
    }
    
    
    function toReplace(divElement,id) {
        var inputElement = document.createElement("input");
        inputElement.id = 'replaceinput'
        var txt = divElement.innerHTML
        inputElement.value = divElement.innerHTML;
        divElement.parentNode.replaceChild(inputElement, divElement);
        inputElement.focus()
        inputElement.onblur = function () {
            divElement.innerHTML = inputElement.value;
            inputElement.parentNode.replaceChild(divElement, inputElement);
            if(inputElement.value == ''){
                divElement.innerHTML = txt;
            }
            if(inputElement.value != ''){
                
                var remark = inputElement.value;
                $.ajax({
                  type: "POST",
                  url: '/group/updateGroupRemark',
                  data:{"id":id,remark:remark},
                  dataType: "json",
                  success: function(res){
                      if(res.code != 0){
                          return layui.layer.msg(res.msg);
                      }
                  },
                  error: function (XMLHttpRequest, textStatus, errorThrown) {
                  }
              });
            }

        }
    }

</script>
</body>
</html>

