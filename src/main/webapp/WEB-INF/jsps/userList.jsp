<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<title>friend</title>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/management.css">
<link rel="stylesheet" type="text/css" href="/layim/css/layui.css" media="all"/>

<style>
.layui-btn+.layui-btn {
    margin-left: auto !important;
}
.FriendInformation .layui-unselect{
	position: absolute;
	top: 8%;
	right:0;
}
</style>
</head>
<body>
    
    <div class="main">
            <div class="layui-row" style="height:100%;">
                <div class="layui-col-sm10 layui-col-sm-offset1" style="height:100%;background: #fff;">
                    
                    <div class="layui-col-sm9" style="height:100%;overflow: auto;">
                        <div class="search_box">
	                        <div class="layui-input-inline">
	                            <input type="text" id="nickName" name="nickName" autocomplete="off" class="layui-input">
	                            <input type="hidden" name="groupId" id="groupId" value="${groupId}"/>
	                        </div>
	                        <button type="button" class="layui-btn" id="search">搜索</button>
	                    </div>
	                    <div class="layui-btn-group btn_box">
                            
                            <button type="button" class="layui-btn" onclick="selectAll();">全选</button>
                            <button type="button" class="layui-btn" onclick="addUserList();">添加</button>
                        </div>
                        <form class="layui-form" action="">
	                        <ul class="FriendDetails" id="UserList">
	                            
	                        </ul>
                        </form>
                        <div id="page" style="margin-right: 10px;float: right;" ></div>
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
    var userCount = '${count}';
    var laypage;
    layui.use(['laypage', 'layer','form'], function(){
       	  laypage = layui.laypage
       	  ,form = layui.form
       	  ,layer = layui.layer;
       	  var groupId = $("#groupId").val();
       	  //总页数低于页码总数
       	  laypage.render({
       		   id: 'UserReload'
       	       ,elem: 'page'
       	       ,count: userCount //数据总数
       	       ,limit:9
       	       ,jump:function(obj,first){
       	    	   $.post('/index/queryUserByList',{page:obj.curr,limit:obj.limit,groupId:groupId},
      	    			   function(result){
      	    		          if(result.data != null && result.data.length > 0){
      	    		        	  $("#UserList").find("li").remove();
	      	   		        	  var html = "";
	      	   		        	  for(var i=0;i<result.data.length;i++){
	      	   		        		    var count = result.data[i].count;
	      		   		        		html += '<li style="position:relative;"><div class="HeadPortrait" style="height: 95px;">'+
	      		                        '<img src="'+result.data[i].avatar+'" alt=""></div><div class="FriendInformation">'+
	      		                        '<p>'+result.data[i].userName+'</p><p>'+result.data[i].nickName+'</p>';
	      		                        if(parseInt(count) > 0){
	      		                        	html +=  '<button class="layui-btn layui-btn-primary layui-btn-sm" style="background: #c8cbce;" disabled>已添加</button>'+
		      		                        '</div></li>';
	      		                        }else{
	      		                        	html +=  '<button class="layui-btn layui-btn-primary layui-btn-sm" onclick="addUserToGroup('+result.data[i].id+',this);" id="btn'+result.data[i].id+'">添加</button>'+
	      		                        	         '<input type="checkbox" lay-skin="primary" name="user" value="'+result.data[i].id+'">'+
		      		                                 '</div></li>';
	      		                        }
	      	   		        	  }
	      	   		        	  $("#UserList").append(html);
	      	   		        	  form.render(); 
      	    		          }
       	    	   });
       	       }
       	  });
       	  
       	  
       	$("#search").click(function(){
       		var groupId = $("#groupId").val();
  		    laypage.render({
     		   id: 'UserReload'
     	       ,elem: 'page'
     	       ,count: userCount //数据总数
     	       ,limit:12
     	       ,jump:function(obj,first){
     	    	   $.post('/index/queryUserByList?groupId='+groupId+'&nickName='+nickName,{page:obj.curr,limit:obj.limit},
    	    			   function(result){
    	    		          if(result.data != null && result.data.length > 0){
    	    		        	  $("#UserList").find("li").remove();
	      	   		        	  var html = "";
	      	   		        	  for(var i=0;i<result.data.length;i++){
		      	   		        		html += '<li><div class="HeadPortrait" style="height: 95px;">'+
	      		                        '<img src="'+result.data[i].avatar+'" alt=""></div><div class="FriendInformation">'+
	      		                        '<p>'+result.data[i].userName+'</p><p>'+result.data[i].nickName+'</p>';
	      		                        if(parseInt(count) > 0){
	      		                        	html +=  '<inupt type="button" value="已添加" style="background: #c8cbce;" class="layui-btn layui-btn-primary layui-btn-sm"/>'+
		      		                        '</div></li>';
	      		                        }else{
	      		                        	html +=  '<button class="layui-btn layui-btn-primary layui-btn-sm" onclick="addUserToGroup('+result.data[i].id+',this);" id="btn'+result.data[i].id+'">添加</button><input type="checkbox" name="user" title="勾选" value="'+result.data[i].id+'">'+
		      		                        '</div></li>';
	      		                        }
	      	   		        	  }
	      	   		        	  $("#UserList").append(html);
    	    		          }else{
    	    		        	$("#UserList").find("li").remove();
    	    		        	  laypage.render({
    	    		        	    elem: 'page'
    	    		        	    ,count: 0 //数据总数
    	    		        	  })
    	    		          }
     	    	   });
     	       }
     	  });
  	   })
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
	      		                        '<p>'+result.data[i].username+'</p><p>'+result.data[i].remark+'</p><button class="layui-btn layui-btn-primary layui-btn-sm">移除群</button>'+
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
    }
    
    
    function addUserToGroup(userId,obj){
    	var groupId = $("#groupId",window.parent.document).val();
    	$.ajax({
            async:false,
            type: "POST",
            url: '/index/finduserIsexistGroup',
            data:{"groupId":groupId,"userId":userId},
            dataType: "json",
            success: function(res){
                if(res.code != 0){
                     layui.layer.msg(res.msg);
                     return;
                }else{
                	$.ajax({
                        async:false,
                        type: "POST",
                        url: '/index/addGroupUser',
                        data:{"groupId":groupId,"userId":userId},
                        dataType: "json",
                        success: function(res){
                        	if(res.code == 0){
                        		$(obj).attr("disabled",true);
                        		$(obj).css("background","#c8cbce");
                        		parent.updateUserCount();
                        		$(obj).html("已添加");
                        		$(obj).unbind("click");
                        	}
                            layui.layer.msg(res.msg);
                            return;
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                        }
                    });
                }
                //layui.layer.msg("移动好友成功，请刷新查看");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }

    function selectAll(){
    	$("input[name='user']").prop("checked",true);
    }
    
    function addUserList(){
    	debugger;
    	var id_array=new Array();  
    	$('input[name="user"]:checked').each(function(){  
    	    id_array.push($(this).val());//向数组中添加元素  
    	});
    	if($('input[name="user"]:checked').lenght == 0){
    		layui.layer.msg("请先勾选要添加的成员!!!!");
    		return;
    	}
    	var idstr=id_array.join(',');//将数组元素连接起来以构建一个字符串  
    	var groupId = $("#groupId").val();
    	$.ajax({
            async:false,
            type: "POST",
            url: '/index/addBatchGroupUser',
            data:{"groupId":groupId,"userIds":idstr},
            dataType: "json",
            success: function(res){
            	if(res.code == 0){
            		for(var i=0;i<id_array.length;i++){
            			$("#btn"+id_array[i]).attr("disabled",true);
            			$("#btn"+id_array[i]).css("background","#c8cbce");
            			$("#btn"+id_array[i]).html("已添加");
                		$("#btn"+id_array[i]).unbind("click");
            		}
            		parent.updateUserSzie(id_array.length);
            	}
                layui.layer.msg(res.msg);
                return;
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }
</script>
</body>
</html>

