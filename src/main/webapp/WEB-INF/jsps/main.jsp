<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<title>即时通讯平台</title>
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="/layim/css/layui.css" media="all"/>
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" href="/css/newindex.css">
</head>
<body>
<input type="hidden" id="userId" value="${user.id}"/>
<input type="hidden" id="nickName" value="${user.nickName}"/>
<div class="contentBigBox">
    <div id="headerNav" class="active">
        <h1>
            <img src="/images/logoico.png" style="width: 40px;margin-top: 0px;">
            <span style="display: inline-block;vertical-align: middle;font-size: 26px;font-family: '时尚中黑简体';line-height: 58px;color: white;">即时通讯平台</span>
        </h1>
        <ul id="nav">
            <li>
                <p>我的好友</p>
            </li>
            <li>
                <p>查找好友</p>
            </li>
            <li>
                <p>群管理</p>
            </li>
        </ul>
        <div class="navTime">
            <ul>
                <li>
                    <img id="avatar" src="${user.avatar}" style="border-radius: 50%;width: 50px;height: 50px;margin-top: 5px;cursor: pointer;">
                </li>
                <li class="userName">
                    <span>${user.nickName} ，欢迎你！</span>

                </li>
            </ul>
        </div>
    </div>
    <a class="layui-btn" href="/index/logout" style="position: absolute;top: 11px;right: 20px;z-index: 1000;">退出登录</a>
</div>
<iframe id="rightframe" name="rightframe" src="" frameborder="0" style="width:100%;height:800px;"></iframe>
<script src="/js/jquery.min.js"></script>
<script src="/layim/layui.js"></script>
<script src="/layim/im.js"></script>
<script>
    $('iframe').height(document.body.clientHeight - $('.contentBigBox').height());
    $('#nav').find('li').on('click', function () {
        if ($(this).index() == 0) {
            $('iframe').attr('src', '/friend/friendManage?userId='+$("#userId").val());
        } else if ($(this).index() == 1) {
            $('iframe').attr('src', '/friend/searchPage?userId='+$("#userId").val());
        } else if ($(this).index() == 2) {
            $('iframe').attr('src', '/group/groupPage?userId='+$("#userId").val());
        }
        $(this).addClass('navActive').siblings().removeClass('navActive');  // 头部导航切换效果
    });
    $("#nav li").first().click();
    layui.use('upload', function() {
        var $ = layui.jquery
            , upload = layui.upload;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#avatar'
            ,accept: 'images'
            ,acceptMime: 'image/*'
            ,field:'imageName'
            , url: '/index/uploadAvatar'
            ,data: {
                userId: function(){
                    return $('#userId').val();
                }
            }
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
//                    $('#avatar').attr('src', result); //图片链接（base64）
                });
            }
            , done: function (res) {
                //如果上传失败
                if (res.code > 0) {
                    return layer.msg(res.msg);
                }
                //上传成功
                $('#avatar').attr('src', res.msg);
            }
            , error: function () {
            }
        });
    });
</script>
</body>
</html>

