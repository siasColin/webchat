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
                            <!-- <input type="hidden" name="orgCode" id="orgCode"/> -->
                        </div>
                        <button type="button" class="layui-btn" id="search">搜索</button>
                    </div>

                    <!-- <div class="layui-col-sm3 tree_box">
                        <div class="tree">
                            <ul id="orgtree" class="ztree" style="overflow: auto;"></ul>
                        </div>
                    </div> -->
                    <div class="layui-col-sm12 search_main">
                        <ul class="searchResult" id="searchResult">
                            <!-- <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p><i>账号: </i><span>u2</span></p>
                                    <p><i class="layui-icon">&#xe612;</i><span>个性签名</span></p>
                                </div>
                                <div class="addfriend">
                                    <button type="button" class="layui-btn layui-btn-sm">+好友</button>
                                </div>
                            </li>
                            <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p><i>账号: </i><span>u2</span></p>
                                    <p><i class="layui-icon">&#xe612;</i><span>个性签名</span></p>
                                </div>
                                <div class="addfriend">
                                    <button type="button" class="layui-btn layui-btn-sm">+好友</button>
                                </div>
                            </li>
                            <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p><i>账号: </i><span>u2</span></p>
                                    <p><i class="layui-icon">&#xe612;</i><span>个性签名</span></p>
                                </div>
                                <div class="addfriend">
                                    <button type="button" class="layui-btn layui-btn-sm">+好友</button>
                                </div>
                            </li>
                            <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p><i>账号: </i><span>u2</span></p>
                                    <p><i class="layui-icon">&#xe612;</i><span>个性签名</span></p>
                                </div>
                                <div class="addfriend">
                                    <button type="button" class="layui-btn layui-btn-sm">+好友</button>
                                </div>
                            </li>
                            <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p><i>账号: </i><span>u2</span></p>
                                    <p><i class="layui-icon">&#xe612;</i><span>个性签名</span></p>
                                </div>
                                <div class="addfriend">
                                    <button type="button" class="layui-btn layui-btn-sm">+好友</button>
                                </div>
                            </li>
                            <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p><i>账号: </i><span>u2</span></p>
                                    <p><i class="layui-icon">&#xe612;</i><span>个性签名</span></p>
                                </div>
                                <div class="addfriend">
                                    <button type="button" class="layui-btn layui-btn-sm">+好友</button>
                                </div>
                            </li>
                            <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p><i>账号: </i><span>u2</span></p>
                                    <p><i class="layui-icon">&#xe612;</i><span>个性签名</span></p>
                                </div>
                                <div class="addfriend">
                                    <button type="button" class="layui-btn layui-btn-sm">+好友</button>
                                </div>
                            </li>
                            <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p><i>账号: </i><span>u2</span></p>
                                    <p><i class="layui-icon">&#xe612;</i><span>个性签名</span></p>
                                </div>
                                <div class="addfriend">
                                    <button type="button" class="layui-btn layui-btn-sm">+好友</button>
                                </div>
                            </li>
                            <li>
                                <div class="HeadPortrait" style="height: 95px;">
                                    <img src="./image/account.png" alt="">
                                </div>
                                <div class="FriendInformation">
                                    <p>马云</p>
                                    <p><i>账号: </i><span>u2</span></p>
                                    <p><i class="layui-icon">&#xe612;</i><span>个性签名</span></p>
                                </div>
                                <div class="addfriend">
                                    <button type="button" class="layui-btn layui-btn-sm">+好友</button>
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
       	    		        	           html += "<button type='button' class='layui-btn layui-btn-sm'>+好友</button></div></li>";
       	    		        	      }
       	    		        		  
       	    		        	  }
       	    		        	  $("#searchResult").append(html);
       	    		          }
        	    	   });
        	       }
        	  });
        	  
        	  
        	  $("#search").click(function(){
        		  var nickName = $("#nickName").val();
        		  var orgCode = $("#orgCode").val();
        		  $.post('/index/queryUserByList?nickName='+nickName+'&userId='+$("#userId",window.parent.document).val(),{page:1,limit:12},
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
               	         	    	    $.post('/index/queryUserByList?nickName='+nickName,{page:obj.curr,limit:obj.limit},
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
               	       	    		        	           html += "<button type='button' class='layui-btn layui-btn-sm'>+好友</button></div></li>";
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
        

       	
       	function delFriend(friendId,obj){
       		var userId = $("#userId",window.parent.document).val();
       		debugger;
        	layer.confirm('你确定要移除用户么?', {icon: 3, title:'提示'}, function(index){
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