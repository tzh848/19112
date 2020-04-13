<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>后台管理</title>
  <link rel="stylesheet" href="./layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">${sessionScope.login_user.username}后台布局</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item"><a href="">控制台</a></li>
      <li class="layui-nav-item"><a href="">商品管理</a></li>
      <li class="layui-nav-item"><a href="">用户</a></li>
      <li class="layui-nav-item">
        <a href="javascript:;">其它系统</a>
        <dl class="layui-nav-child">
          <dd><a href="">邮件管理</a></dd>
          <dd><a href="">消息管理</a></dd>
          <dd><a href="">授权管理</a></dd>
        </dl>
      </li>
    </ul>
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
         <c:if test="${TIP_COUNT!=0}">
         <span><span class="layui-badge">${TIP_COUNT}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
         </c:if>
         ${sessionScope.login_user.username}
        </a>
        <dl class="layui-nav-child">
          <dd><a href="">基本资料</a></dd>
          <dd><a href="">安全设置</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="">退了</a></li>
    </ul>
  </div>
  
  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
        <!-- <li class="layui-nav-item layui-nav-itemed">
          <a class="" href="javascript:;">所有商品</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:;">列表一</a></dd>
            <dd><a href="javascript:;">列表二</a></dd>
            <dd><a href="javascript:;">列表三</a></dd>
            <dd><a href="">超链接</a></dd>
          </dl>
        </li> -->
        <!-- <li class="layui-nav-item">
          <a href="javascript:;">解决方案</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:;">列表一</a></dd>
            <dd><a href="javascript:;">列表二</a></dd>
            <dd><a href="">超链接</a></dd>
          </dl>
        </li> -->
        <li class="layui-nav-item"><a href="javascript:void(0);" pag="sys/user">用户角色管理</a></li>
        <li class="layui-nav-item"><a href="javascript:void(0);" pag="sys/perm">角色权限管理</a></li>
        <li class="layui-nav-item"><a href="javascript:void(0);" pag="sys/customer">客户管理</a></li>
        <li class="layui-nav-item"><a href="javascript:void(0);" pag="sys/publiccus">公海客户管理</a></li>
        <li class="layui-nav-item"><a href="javascript:void(0);" pag="sys/privatecus">私人客户管理</a></li>
        <li class="layui-nav-item"><a href="javascript:void(0);" pag="sys/visit">回访信息管理</a></li>
        <li class="layui-nav-item"><a href="javascript:void(0);" pag="sys/bumen">部门管理</a></li>
      </ul>
    </div>
  </div>
  
  <div class="layui-body">
    <!-- 内容主体区域 -->
   <iframe style="height:98%;width:98%;" src=""></iframe>
  </div>
  
  <div class="layui-footer">
    <!-- 底部固定区域 -->
    © layui.com - 底部固定区域
  </div>
</div>
<script type="text/javascript" src="./layui/layui.all.js"></script>
<script>
var table = layui.table;
var layer = layui.layer;
var $ = layui.jquery;
//JavaScript代码区域
layui.use('element', function(){
  var element = layui.element;
  
});

var $=layui.jquery;
$("[pag]").click(function(){
	$("iframe").attr("src",$(this).attr("pag"));
});
</script>
</body>
</html>