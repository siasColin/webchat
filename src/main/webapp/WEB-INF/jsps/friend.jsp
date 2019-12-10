<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<title>friend</title>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/layim/css/layui.css" media="all"/>
<link rel="stylesheet" href="/css/friend.css">
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
                <ul class="Grouping">
                <c:forEach items="${mineFriendTypeList}" var="mineFriendType" >
                    <li data-id="${mineFriendType.id}" id="liobj${mineFriendType.id}" onclick="friendClick(this)">
                        <span>${mineFriendType.type_name}</span>
                        <i id="friendType${mineFriendType.id}">${mineFriendType.total}</i>
                    </li>
                </c:forEach>
                </ul>
                <input type="hidden" name="friendTypeId" id="friendTypeId" value=""/>
                <button class="addgroup layui-btn layui-btn-primary" type="button" onclick="addFriendType();">添加分组</button>
                <button class="addgroup layui-btn layui-btn-primary" type="button" onclick="delFriendType();">删除分组</button>
                <button class="addgroup layui-btn layui-btn-primary" type="button" onclick="updateFriendType();">修改分组</button>
            </div>
            <div class="layui-col-sm9" style="height:100%;overflow: auto;">
                <ul class="FriendDetails" >

                </ul>
            </div>
        </div>
    </div>

</div>
<script src="/js/jquery.min.js"></script>
<script src="/layim/layui.all.js"></script>
<script>
    document.onselectstart = function () { return false; };
    
    layui.use(['layer','form'], function () {
        var form = layui.form;
    });
    function friendClick(obj){
        $(obj).addClass('li_active').siblings().removeClass('li_active');
        $("#friendTypeId").val($(obj).attr("data-id"));
        //加载分组下好友
        $.ajax({
//            async:false,
            type: "POST",
            url: '/friend/getFriendByTypeId',
            data:{"typeId":$(obj).attr("data-id"),userId:$("#userId",window.parent.document).val()},
            dataType: "json",
            success: function(res){
                if(res.code != 0){
                    return layui.layer.msg(res.msg);
                }
                setFriend(res.data);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }
    function setFriend(data) {
        var friendhtml = '';
        for(var i = 0;i < data.length; i++) {
            var typeSelectHtml = '<select name="city" lay-verify="" lay-filter="test" id="typeselect'+data[i].id+'">';
            $('.Grouping').find('li').each(function() {
                if($(this).index() != 0){
                    typeSelectHtml += '<option value="'+$(this).attr("data-id")+'"';
                            if($(this).attr("data-id") == data[i].type_id){
                                typeSelectHtml += 'selected=selected';
                            }
                    typeSelectHtml += '>'+$(this).find("span").text()+'</option>';
                }
            })
            typeSelectHtml+='</select>';
            friendhtml += '<li><div class="HeadPortrait" style="height: 95px;"><img src="'+data[i].avatar+'" alt="">' +
                '</div><div class="FriendInformation"><p class="name">'+data[i].nick_name+
                '</p><p>备注：<i ondblclick="toReplace(this,'+data[i].id+')">'+data[i].remark+
                '</i></p><div class="SetGrouping"><div class="layui-input-inline layui-form">' +
                typeSelectHtml +
                '</div> <button type="button" class="layui-btn layui-btn-normal layui-btn-radius layui-btn-xs" onclick="moveFriendType('+data[i].id+');">移动至</button>' +
                '</div><button class="layui-btn layui-btn-primary layui-btn-xs" onclick="deleteFriend(this,'+data[i].id+');">删除</button></div></li>';
        }
        $(".FriendDetails").html(friendhtml);
        layui.form.render('select');
    }
    $(".Grouping li").first().click();
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
                //$(divElement).parent().siblings('.name').text(inputElement.value);
                var remark = inputElement.value;
                $.ajax({
                  type: "POST",
                  url: '/friend/updateRemark',
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
    function addFriendType(){
        layui.layer.open({
            title:"添加群组",
            type: 2,
            area: ['450px','300px'],
            btn: ['保存', '取消'],
            offset: 't',
            content: '/friend/addFriendTypePage?userId='+$("#userId",window.parent.document).val(),
            yes: function(index,layero){
                // 获取iframe层的body
                var body = layer.getChildFrame('body', index);
                // 找到隐藏的提交按钮模拟点击提交
                body.find('#permissionSubmit').click();
            }
        });
    }
    
    function updateFriendType(){
    	var friendTypeId = $("#friendTypeId").val();
    	layui.layer.open({
            title:"更新群组",
            type: 2,
            area: ['450px','300px'],
            btn: ['保存', '取消'],
            content: '/friend/updateFriendTypePage?id='+friendTypeId,
            yes: function(index,layero){
                // 获取iframe层的body
                var body = layer.getChildFrame('body', index);
                // 找到隐藏的提交按钮模拟点击提交
                body.find('#permissionSubmit').click();
            }
        });
    }
    function appendFriendType(typeName,typeId){
        var html = '<li data-id="'+typeId+'" onclick="friendClick(this)"><span>'+typeName+'</span><i>0</i></li>';
        $(".Grouping").append(html);
    }
    function moveFriendType(friendId){
        var friendTypeObj = $("#typeselect"+friendId);
        $.ajax({
            async:false,
            type: "POST",
            url: '/friend/updateFriendType',
            data:{"typeId":friendTypeObj.val(),friendId:friendId},
            dataType: "json",
            success: function(res){
                if(res.code != 0){
                    return layui.layer.msg(res.msg);
                }
                layui.layer.msg("移动好友成功，请刷新查看");
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }
    
    function delFriendType(){
    	var friendTypeId = $("#friendTypeId").val();
    	if(friendTypeId == '-1'){
    		layer.msg("请先选择要删除的群组!!!");
    		return;
    	}else{
    		layer.confirm('你确定要删除选中的群组么?', {icon: 3, title:'提示'}, function(index){
    			$.ajax({
                    async:false,
                    type: "POST",
                    url: '/friend/deleteFriendTypeById',
                    data:{"id":friendTypeId},
                    dataType: "json",
                    success: function(res){
                    	layui.layer.msg(res.msg);
                        if(res.code == 0){
                            $("#liobj"+friendTypeId).remove();
                        	
                        }
                        //layui.layer.msg("移动好友成功，请刷新查看");
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                    }
                });
    		    layer.close(index);
    		});
    		
    	}
    }
    
    function deleteFriend(obj,id){
    	$(obj).parent().parent().remove();
    	$.ajax({
            type: "POST",
            url: '/friend/deleteFriendById',
            data:{"id":id},
            dataType: "json",
            success: function(res){
                if(res.code != 0){
                    return layui.layer.msg(res.msg);
                }else{
                	var friendTypeId = $("#friendTypeId").val();
                	var numhtml = $("#friendType"+friendTypeId).html();
                	var newnum = parseInt(numhtml) - 1;
                	$("#friendType"+friendTypeId).html(newnum);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }
    
    function updateFriendTypeNameLi(typeName,id){
    	$("#liobj"+id).find("span").html(typeName);
    }
</script>
</body>
</html>

