<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<title>search</title>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title></title>
    <link rel="stylesheet" href="/css/reset.css">
    <link rel="stylesheet" type="text/css" href="/layim/css/layui.css" media="all"/>
    <link rel="stylesheet" href="/css/search.css">
    <link rel="stylesheet" href="/js/zTree_v3/css/metro.css" type="text/css">
    <link rel="stylesheet" href="/js/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>

<body>

        <div class="main">
            <div class="layui-row" style="height:100%;">
                <div class="layui-col-sm10 layui-col-sm-offset1" style="height:100%;background: #fff;">
                    <div class="search_box">
                        <div class="layui-input-inline">
                            <input type="text" id="nickName" name="nickName" autocomplete="off" class="layui-input">
                            <input type="hidden" name="orgCode" id="orgCode"/>
                        </div>
                        <button type="button" class="layui-btn" id="search">搜索</button>
                        
                        <button type="button" class="layui-btn" id="syncUser">同步好友</button>
                    </div>

                    <%--<div class="layui-col-sm3 tree_box" >
                        <div class="tree">
                            <ul id="orgtree" class="ztree" style="overflow: auto;"></ul>
                        </div>
                    </div>--%>
                    <div class="layui-col-sm9 search_main" style="left: 10%;">
                        <ul class="searchResult" id="searchResult">
                        </ul>
                        <div id="page" style="margin-right: 10px;float: right;"></div>
                    </div>
                </div>
            </div>
        </div>
        
        <script src="/js/jquery.min.js"></script>
        <script src="/layim/layui.all.js"></script>
        <!-- 引入ztree插件 -->
        <script type="text/javascript" src="/js/zTree_v3/js/jquery.ztree.all.min.js"></script>
    <script>
        document.onselectstart = function () { return false; };
        var h = $('.main').outerHeight(true) - $('.search_box').outerHeight(true);
        $('.tree_box').height(h-3);
        $('.search_main').height(h-10);
        var count = '${count}';
        var laypage;
        layui.use(['laypage', 'layer'], function(){
        	  laypage = layui.laypage
        	  ,layer = layui.layer;
        	  //总页数低于页码总数
        	  laypage.render({
        		   id: 'UserReload'
        	       ,elem: 'page'
        	       ,count: count //数据总数
        	       ,limit:12
        	       ,jump:function(obj,first){
        	    	   $.post('/index/queryUserByList?userId='+$("#userId",window.parent.document).val(),{page:obj.curr,limit:obj.limit},
       	    			   function(result){
       	    		          if(result.data != null && result.data.length > 0){
       	    		        	  $("#searchResult").find("li").remove();
       	    		        	  var html = "";
       	    		        	  for(var i=0;i<result.data.length;i++){
       	    		        		  html += "<li><div class='HeadPortrait' style='height: 95px;'>";
       	    		        		  html += "<img src='"+result.data[i].avatar+"' alt=''></div><div class='FriendInformation'>";
       	    		        		  html += "<p>"+result.data[i].nickName+"</p><p><i>账号: </i><span>"+result.data[i].userName+"</span></p> <p><i class='layui-icon'>&#xe612;</i><span>"+result.data[i].sign+"</span></p>";
       	    		        		  html += "</div><div class='addfriend'>";
       	    		        		  if(parseInt(result.data[i].count) > 0){
       	    		        	           html += "<button type='button' class='layui-btn layui-btn-sm' style='background: #c8cbce;' onclick='delFriend("+result.data[i].id+",this);'>移除</button></div></li>";
       	    		        	      }else{
       	    		        	           html += "<button type='button' class='layui-btn layui-btn-sm' onclick='addFriend("+result.data[i].id+",\""+result.data[i].avatar+"\",\""+result.data[i].nickName+"\");'>+好友</button></div></li>";
       	    		        	      }
       	    		        		  
       	    		        	  }
       	    		        	  $("#searchResult").append(html);
       	    		          }
        	    	   });
        	       }
        	  });
        	  
        	  $("#syncUser").click(function(){
        		   $.ajax({
             	        url : "/friend/syncSysUser",//请求的action路径
             	        type : "post",
             	        dataType : "json",
             	        success : function(data) {
             	        	layui.layer.msg(res.msg);
                            return;
             	        },
             	        error : function() {

             	        }
             	    });
        	  })
        	  
        	  
        	  $("#search").click(function(){
        		  var nickName = $("#nickName").val();
        		  var orgCode = $("#orgCode").val();
        		  $.post('/index/queryUserByList?nickName='+nickName+'&orgCode='+orgCode+'&userId='+$("#userId",window.parent.document).val(),{page:1,limit:12},
   	    			   function(result){
               	          debugger;
               	          if(result.data != null && result.data.length > 0){
               	        	   var userCount = result.count;
               	        	   laypage.render({
               	         		   id: 'UserReload'
               	         	       ,elem: 'page'
               	         	       ,count: userCount //数据总数
               	         	       ,limit:12
               	         	       ,jump:function(obj,first){
               	         	    	    $.post('/index/queryUserByList?nickName='+nickName+'&orgCode='+orgCode,{page:obj.curr,limit:obj.limit},
               	       	    			   function(result){
               	       	    		          if(result.data != null && result.data.length > 0){
               	       	    		        	  $("#searchResult").find("li").remove();
               	       	    		        	  var html = "";
               	       	    		        	  for(var i=0;i<result.data.length;i++){
               	       	    		        		  html += "<li><div class='HeadPortrait' style='height: 95px;'>";
               	       	    		        		  html += "<img src='"+result.data[i].avatar+"' alt=''></div><div class='FriendInformation'>";
               	       	    		        		  html += "<p>"+result.data[i].nickName+"</p><p><i>账号: </i><span>"+result.data[i].userName+"</span></p> <p><i class='layui-icon'>&#xe612;</i><span>"+result.data[i].sign+"</span></p>";
               	       	    		        		  html += "</div><div class='addfriend'>";
               	       	    		        	      if(parseInt(result.data[i].count) > 0){
               	       	    		        	           html += "<button type='button' class='layui-btn layui-btn-sm' style='background: #c8cbce;' onclick='delFriend("+result.data[i].id+",this);'>移除</button></div></li>";
               	       	    		        	      }else{
               	       	    		        	           html += "<button type='button' class='layui-btn layui-btn-sm' onclick='addFriend("+result.data[i].id+",\""+result.data[i].avatar+"\",\""+result.data[i].nickName+"\");'>+好友</button></div></li>";
               	       	    		        	      }
               	       	    		        		  
               	       	    		        	  }
               	       	    		        	  $("#searchResult").append(html);
               	       	    		          }
               	        	    	   });
               	         	       }
               	         	  });
               	          }else{
               	        	  $("#searchResult").find("li").remove();
   	    		        	  laypage.render({
   	    		        	    elem: 'page'
   	    		        	    ,count: 0 //数据总数
   	    		        	  })
               	          }
                   })
        	  })
        });
        
        
        var setting = {
        	    view: {
        	        dblClickExpand: false,//双击节点时，是否自动展开父节点的标识
        	        showLine: true,//是否显示节点之间的连线
        	        radioCss:{'color':'black','font-weight':'bold'},//字体样式函数
        	        fontCss:{'color':'black','font-weight':'bold'},//字体样式函数
        	        selectedMulti: false //设置是否允许同时选中多个节点
        	    },
        	    check:{
        	        //chkboxType: { "Y": "ps", "N": "ps" },
        	        //chkStyle: "radio",//单选
        	        //enable: true //每个节点上是否显示 CheckBox
        	    },
        	    data: {
        	        simpleData: {//简单数据模式
        	            enable:true,
        	            idKey: "id",
        	            pIdKey: "pId",
        	            rootPId: ""
        	        }
        	    },
        	    callback : {
        	        onClick : zTreeOnclick
        	    }
        };

       	$(document).ready(function() {
       	    /*initZTree();*/
       	});

       	/*function initZTree() {
       	    $.ajax({
       	        url : "/index/queryOrgListZtree",//请求的action路径
       	        type : "post",
       	        data:{"pid":""},
       	        dataType : "json",
       	        success : function(data) {
       	            var t=$.fn.zTree.init($("#orgtree"), setting, data);
       	            var nodes = t.getNodes();
       	            for (var i = 0; i < nodes.length; i++) { //设置节点展开(二级节点)
       	                t.expandNode(nodes[i], true, false, true);
       	            }
       	        },
       	        error : function() {

       	        }
       	    });
       	}
       	function zTreeOnclick(event, treeId, treeNode) {
            var orgid = treeNode.id;
            var orgname = treeNode.name;
            $("#orgCode").val(orgid);
            var nickName = $("#nickName").val();
            $.post('/index/queryUserByList?nickName='+nickName+'&orgCode='+orgid+'&userId='+$("#userId",window.parent.document).val(),{page:1,limit:12},
	    			   function(result){

            	          if(result.data != null && result.data.length > 0){
            	        	   var userCount = result.count;
            	        	   laypage.render({
            	         		   id: 'UserReload'
            	         	       ,elem: 'page'
            	         	       ,count: userCount //数据总数
            	         	       ,limit:12
            	         	       ,jump:function(obj,first){
            	         	    	       $.post('/index/queryUserByList?nickName='+nickName+'&orgCode='+orgid+'&userId='+$("#userId",window.parent.document).val(),{page:obj.curr,limit:obj.limit},
                  	       	    			   function(result){
                  	       	    		          if(result.data != null && result.data.length > 0){
                  	       	    		        	  $("#searchResult").find("li").remove();
                  	       	    		        	  var html = "";
                  	       	    		        	  for(var i=0;i<result.data.length;i++){
                  	       	    		        		  html += "<li><div class='HeadPortrait' style='height: 95px;'>";
                  	       	    		        		  html += "<img src='"+result.data[i].avatar+"' alt=''></div><div class='FriendInformation'>";
                  	       	    		        		  html += "<p>"+result.data[i].nickName+"</p><p><i>账号: </i><span>"+result.data[i].userName+"</span></p> <p><i class='layui-icon'>&#xe612;</i><span>"+result.data[i].sign+"</span></p>";
                  	       	    		        		  html += "</div><div class='addfriend'>";
                  	       	    		        		  if(parseInt(result.data[i].count) > 0){
                	       	    		        	           html += "<button type='button' class='layui-btn layui-btn-sm' style='background: #c8cbce;' onclick='delFriend("+result.data[i].id+",this);'>移除</button></div></li>";
                	       	    		        	      }else{
                	       	    		        	           html += "<button type='button' class='layui-btn layui-btn-sm' onclick='addFriend("+result.data[i].id+",\""+result.data[i].avatar+"\",\""+result.data[i].nickName+"\");'>+好友</button></div></li>";
                	       	    		        	      }
                  	       	    		        		  //"<button type='button' class='layui-btn layui-btn-sm'>+好友</button></div></li>";
                  	       	    		        	  }
                  	       	    		        	  $("#searchResult").append(html);
                  	       	    		          }
                  	        	    	   });
            	         	       }
            	         	  });
            	          }else{
            	        	  $("#searchResult").find("li").remove();
	    		        	  laypage.render({
	    		        	    elem: 'page'
	    		        	    ,count: 0 //数据总数
	    		        	  })
            	          }
            })
       	};*/
        function addFriend(uid,avatar,username){
            parent.layui.layim.add({
                type: 'friend' //friend：申请加好友、group：申请加群
                ,username: username //好友昵称，若申请加群，参数为：groupname
                ,avatar: avatar //头像
                ,submit: function(group, remark, index){ //一般在此执行Ajax和WS，以通知对方
//                    console.log(group); //获取选择的好友分组ID，若为添加群，则不返回值
//                    console.log(remark); //获取附加信息
                    var userId = $("#userId",window.parent.document).val();
                    $.ajax({
                        async:false,
                        type: "POST",
                        url: '/friend/sendAddFriend',
                        data:{"from":userId,"from_group":group,"remark":remark,"uid":uid},
                        dataType: "json",
                        success: function(res){
                            if(res.code != 0){
                                return layui.layer.msg(res.msg);
                            }
                            parent.layer.close(index); //关闭改面板
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                        }
                    });
                }
            });
        }
        function delFriend(friendId,obj){
            var userId = $("#userId",window.parent.document).val();
            debugger;
            layer.confirm('你确定要移除用户么?', {icon: 3,offset: 't', title:'提示'}, function(index){
                $.ajax({
                    async:false,
                    type: "POST",
                    url: '/friend/deleteFriendByFriendId',
                    data:{"userId":userId,"friendId":friendId},
                    dataType: "json",
                    success: function(res){
                        if(res.code == 0){
                            $(obj).css("background","#4eaf4d");
                            $(obj).html("+好友");
                            return;
                        }
                        layui.layer.msg(res.msg);
                        //layui.layer.msg("移动好友成功，请刷新查看");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    }
                });
                layer.close(index);
            });
        }
    </script>
</body>

</html>