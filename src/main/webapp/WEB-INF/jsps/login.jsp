<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>即时通讯平台</title>
    <link rel="shortcut icon" href="favicon.ico"> <link href="/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
    <link href="/css/animate.min.css" rel="stylesheet">
    <link href="/css/style.min.css?v=4.1.0" rel="stylesheet">
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
</head>

<body class="gray-bg">
    <div class="middle-box text-center loginscreen  animated fadeInDown">
        <div>
            <div>
            <h6 class="logo-name">即时通讯平台</h6>
            </div>
            <h3></h3>
			       <form action="/index/loginCheck" method="post">
			              <div class="form-group">
			                  <input type="username" class="form-control" placeholder="用户名" name="userName" required/>
			              </div>
			              <div class="form-group">
			                  <input type="password" class="form-control" placeholder="密码" name="password" required/>
			              </div>
			              <button type="submit" id="sbBtn" class="btn btn-primary block full-width m-b">登录</button>
			               <p class="text-muted text-center" style="font-size:14px;color:red"> ${msg} </p>
					 	   <p class="text-muted text-center"><a href="javascript:;" onclick="userRegister();">注册新账号</a></p>
			       </form>
        </div>
    </div>
    <script src="/js/jquery.min.js"></script>
    <script src="/layim/layui.all.js"></script>
    <script>
        function userRegister(){
            layui.layer.open({
                title:"新用户注册",
                type: 2,
                area: ['450px','350px'],
                btn: ['保存', '取消'],
                content: '/index/userRegisterPage',
                yes: function(index,layero){
                    // 获取iframe层的body
                    var body = layer.getChildFrame('body', index);
                    // 找到隐藏的提交按钮模拟点击提交
                    body.find('#permissionSubmit').click();
                }
            });
        }
    </script>
</body>
</html>

