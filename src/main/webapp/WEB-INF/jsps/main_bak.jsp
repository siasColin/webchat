<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<title>KingIM</title>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="/layim/css/layui.css" media="all"/>
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/index.css">
</head>
<body>
<input type="hidden" id="userId" value="${user.id}"/>
<input type="hidden" id="nickName" value="${user.nickName}"/>
<div class="page">
    <div class="header">
        <ul class="layui-nav layui-bg-green head_nav">
            <li class="layui-nav-item layui-this"><a href="javascript:;">我的好友</a></li>
            <li class="layui-nav-item"><a href="javascript:;">查找好友</a></li>
            <li class="layui-nav-item"><a href="javascript:;">群管理</a></li>
        </ul>
        <a class="layui-btn" href="/index/logout" style="position: absolute;top: 13px;right: 20px;">退出登录</a>
    </div>
    <iframe src="/friend.html" style="display:block;" width="100%" scrolling='no' frameborder="0"></iframe>
</div>


<script src="/js/jquery.min.js"></script>
<script src="/layim/layui.js"></script>
<script src="/layim/im.js"></script>
<script>
    document.onselectstart = function () { return false; };

    layui.use(['element'], function () {
        var element = layui.element; //导航的hover效果、二级菜单等功能，需要依赖element模块

        //监听导航点击
        element.on('nav(demo)', function (elem) {
            //console.log(elem)
            layer.msg(elem.text());
        });
    });
    $('iframe').height($('.page').height() - $('.header').height())
    $('.head_nav').find('li').on('click', function () {
        if ($(this).index() == 0) {
            $('iframe').attr('src', '/friend.html')
        } else if ($(this).index() == 1) {
            $('iframe').attr('src', 'management.html')
        } else if ($(this).index() == 2) {
            $('iframe').attr('src', 'search.html')
        }
    })
</script>
</body>
</html>

