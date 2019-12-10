<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<title>添加分组</title>
<link rel="stylesheet" type="text/css" href="/layim/css/layui.css" media="all"/>
<style>
.span-red {
	margin: 5px;
	color: red;
}
</style>
</head>
<body>
	<div class="layui-container">
		<form id="form1" class="layui-form" style="margin-top: 4%">
			<input id="id" name="id" type="hidden" value="${group.id}" />
			<div class="layui-form-item" hidden>
				<div class="layui-input-block">
					<button id="permissionSubmit" class="layui-btn" lay-submit
						lay-filter="save">保存</button>
				</div>
			</div>
			<!-- 第一行 -->
			<div class="layui-row">
				<div class="layui-col-xs2"></div>
				<div class="layui-col-xs10">
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="span-red">*</span>群组名称</label>
						<div class="layui-input-block">
							<input type="text" id="groupName" name="groupName"
								value="${group.groupName}"
								lay-verify="required|dasLength" daslength="50"
								placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="span-red">*</span>群组编号</label>
						<div class="layui-input-block">
							<input type="text" id="groupNum" name="groupNum"
								value="${group.groupNum}"
								lay-verify="required|dasLength" daslength="50"
								placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">简介</label>
						<div class="layui-input-block">
							<input type="text" id="description" name="description"
								value="${group.description}" daslength="50"
								placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">图标</label>
						<div class="layui-input-block">
							<img id="avatarGroup" src="${group.avatar}" style="border-radius: 50%;width: 50px;height: 50px;margin-top: 5px;cursor: pointer;">
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<script src="/js/jquery.min.js"></script>
	<script src="/layim/layui.all.js"></script>
	<script src="/js/layuiFromVerify.js"></script>
	<script>
    layui.use('form', function(){
        var form = layui.form;
        var upload = layui.upload;
        form.render('select'); //刷新select选择框渲染
        
        var uploadInst = upload.render({
            elem: '#avatarGroup'
            ,accept: 'images'
            ,acceptMime: 'image/*'
            ,field:'imageName'
            ,url: '/index/uploadAvatar'
            ,data: {
                userId: -9999
            }
            ,before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                });
            }
            ,done: function (res) {
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg(res.msg);
                }
                //上传成功
                $('#avatarGroup').attr('src', res.msg);
            }
            , error: function () {
            }
        });
        
        
        //监听提交
        form.on('submit(save)', function(data){
            var groupName = $("#groupName").val();
            var groupNum = $("#groupNum").val();
            var description = $("#description").val();
            var id = $("#id").val();
            var avatar = $('#avatarGroup').attr('src');
            var params={"id":id,"groupName":groupName,"groupNum":groupNum,"description":description,"avatar":avatar};
            $.ajax({
                type : 'POST',
                url :'/group/updateGroup',
                data :params,
                dataType : 'json',
                success : function(obj) {
                    if(obj.code == 0){
                    	debugger;
                        // 成功提示框
                        parent.layer.msg('添加成功', {
                            icon : 6,
                        });
                        parent.layer.closeAll('iframe'); //关闭弹框
                        parent.appendUpateGroup(groupName,description);
                    }else{
                        parent.layer.msg(obj.msg, {
                            icon : 5,
                        });
                    }
                },
                error : function(obj) {
                    // 异常提示
                    parent.layer.msg('出现网络故障', {
                        icon : 5
                    });
                    parent.layer.closeAll('iframe'); //关闭弹框
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
