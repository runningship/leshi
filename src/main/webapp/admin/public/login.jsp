<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>后台管理系统</title>
	<meta charset="UTF-8">
   <link rel="stylesheet" type="text/css" href="../Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <script type="text/javascript" src="../Js/jquery.js"></script>
    <script type="text/javascript" src="../Js/bootstrap.js"></script>
    <script type="text/javascript" src="../Js/ckform.js"></script>
    <script type="text/javascript" src="../Js/common.js"></script>
    <script type="text/javascript" src="../Js/artDialog/jquery.artDialog.source.js?skin=default"></script>
	<script type="text/javascript" src="../Js/artDialog/plugins/iframeTools.source.js"></script>
	<script type="text/javascript" src="../Js/buildHtml.js"></script>
    <style type="text/css">
        body {
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #f5f5f5;
        }

        .form-signin {
            max-width: 300px;
            padding: 19px 29px 29px;
            margin: 0 auto 20px;
            background-color: #fff;
            border: 1px solid #e5e5e5;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
            border-radius: 5px;
            -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
            box-shadow: 0 1px 2px rgba(0, 0, 0, .05);
        }

        .form-signin .form-signin-heading,
        .form-signin .checkbox {
            margin-bottom: 10px;
        }

        .form-signin input[type="text"],
        .form-signin input[type="password"] {
            font-size: 16px;
            height: auto;
            margin-bottom: 15px;
            padding: 7px 9px;
        }

    </style>
<script type="text/javascript">
function login(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'post',
	    url: '/leshi/c/admin/user/login',
	    data: a,
	    mysuccess: function(json){
	        window.location="/leshi/admin/index.jsp#1/2";
	    }
	  });
}
$(function(){
	$(document).on('keyup',function(event){
		if(event.keyCode==13){
			login();
		}
	});
});
</script>
</head>
<body>
<div class="container">

    <form class="form-signin"  name="form1">
        <h2 class="form-signin-heading">登录系统</h2>
        <input type="text" name="name" class="input-block-level" placeholder="账号">
        <input type="password" name="pwd" class="input-block-level" placeholder="密码">
        
        <p><button class="btn btn-large btn-primary" type="button" onclick="login();">登录</button></p>
    </form>
	
</div>
</body>
</html>