<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<title>新用户注册</title>
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
			<input id="userId" name="userId" type="hidden" value="${userId}" />
			<div class="layui-form-item" hidden>
				<div class="layui-input-block">
					<button id="permissionSubmit" class="layui-btn" lay-submit
						lay-filter="save">提交</button>
				</div>
			</div>
			<!-- 第一行 -->
			<div class="layui-row">
				<div class="layui-col-xs2"></div>
				<div class="layui-col-xs10">
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="span-red">*</span>用户名</label>
						<div class="layui-input-block">
							<input type="text" id="userName" name="userName"
								value=""
								lay-verify="required|dasLength" daslength="50"
								placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
				</div>
			</div>
			<!-- 第二行 -->
			<div class="layui-row">
				<div class="layui-col-xs2"></div>
				<div class="layui-col-xs10">
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="span-red">*</span>密码</label>
						<div class="layui-input-block">
							<input type="password" id="password" name="password"
								   value=""
								   lay-verify="required"
								   placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
				</div>
			</div>
			<!-- 第三行 -->
			<div class="layui-row">
				<div class="layui-col-xs2"></div>
				<div class="layui-col-xs10">
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="span-red">*</span>昵称</label>
						<div class="layui-input-block">
							<input type="text" id="nickName" name="nickName"
								   value=""
								   lay-verify="required"
								   placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
				</div>
			</div>
			<!-- 第四行 -->
			<div class="layui-row">
				<div class="layui-col-xs2"></div>
				<div class="layui-col-xs10">
					<div class="layui-form-item">
						<label class="layui-form-label"><span class="span-red">*</span>性别</label>
						<div class="layui-input-block">
							<input type="radio" name="gender" value="0" title="男" checked="">
							<input type="radio" name="gender" value="1" title="女">
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
        form.render('select'); //刷新select选择框渲染
        //监听提交
        form.on('submit(save)', function(data){
            var userName = $("#userName").val();
            var password = $("#password").val();
            var nickName = $("#nickName").val();
            var gender = $('input[name="gender"]:checked').val();
            var params={"userName":userName,"password":password,"nickName":nickName,"gender":gender};
            $.ajax({
                type : 'POST',
                url :'/index/userRegister',
                data :params,
                dataType : 'json',
                success : function(obj) {
                    if(obj.code == 0){
                        // 成功提示框
                        parent.layer.msg('注册成功', {
                            icon : 6,
                        });
                        parent.layer.closeAll('iframe'); //关闭弹框
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
