<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <script type="text/javascript" src="../Js/jquery.js"></script>
    <script type="text/javascript" src="../Js/bootstrap.js"></script>
    <script type="text/javascript" src="../Js/ckform.js"></script>
    <script type="text/javascript" src="../Js/common.js"></script>
     <script type="text/javascript" src="../Js/buildHtml.js"></script>
     <script type="text/javascript" charset="utf-8" src="../Js/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../Js/ueditor1_4_3/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="../Js/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="../Js/artDialog/jquery.artDialog.source.js?skin=default"></script>
    <script type="text/javascript" src="../Js/artDialog/plugins/iframeTools.source.js"></script>
    <script type="text/javascript" src="../Js/buildHtml.js"></script>

    <style type="text/css">
        body {
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }


    </style>
<script type="text/javascript">
function changeModule(sel){
	$('.lanmu_select').css('display','none').removeAttr('name');
	$('#'+sel.value).css('display','').attr('name' , 'bid');
}
$(function(){
	var ue = UE.getEditor('editor');
	ue.addListener( 'ready', function( editor ) {
		ue.setContent('${post.conts}');
 	 });
    //先赋值module
    $('#module').val('${moduleId}');
    changeModule($('#module')[0]);
    //再赋值栏目
    $('#${moduleId}').val('${post.bid}');
});
</script>
</head>
<body>
<form name="form1" method="post" class="definewidth m20">
<input name="fid" id="fid" type="hidden">
<input name="id" id="id" type="hidden">
<table class="table table-bordered table-hover m10">
	<tr>
        <td class="tableleft">栏目</td>
        <td>
        	<select id="module" onchange="changeModule(this)">
                <c:forEach items="${modules}"  var="module">
        			<option value="${module.id}">${module.name}</option>
                </c:forEach>
        	</select>
        	<c:forEach items="${modules}"  var="module">
	        	<select id="${module.id}" style="display:none" class="lanmu_select" name="bid">
	                <c:forEach items="${module.children}"  var="lanmu">
	                    <option value="${lanmu.id}">${lanmu.name}</option>
	                </c:forEach>
	        	</select>
        	</c:forEach>
        </td>
    </tr>
    <tr>
        <td class="tableleft">标题</td>
        <td><input type="text" name="title" value="${post.title}" /></td>
    </tr>
    <tr>
        <td class="tableleft">序号</td>
        <td><input type="text" name="orderx" value="${post.orderx}"/></td>
    </tr>
    <tr>
        <td class="tableleft">正文</td>
        <td>
        	<span id="editor" type="text/plain" name="conts" value="${post.conts}" style="width:99%;height:300px;"></span>
        </td>
    </tr>
    
    <tr>
        <td class="tableleft"></td>
        <td>
            <button class="btn btn-primary" type="button" onclick="save();return false;">保存</button> &nbsp;&nbsp;<button type="button" class="btn btn-success" name="backid" id="backid">返回列表</button>
        </td>
    </tr>
</table>
</form>
</body>
</html>
<script>
    $(function () {       
		$('#backid').click(function(){
			window.location.href="topBoard.jsp";
		 });
        var fid = getParam('fid');
        $('#fid').val(fid);
        var id = getParam('id');
        $('#id').val(id);
    });

function save(){
    var a=$('form[name=form1]').serialize();
    YW.ajax({
        type: 'POST',
        url: '/leshi/c/admin/post/update',
        data:a,
        mysuccess: function(data){
            art.dialog.opener.doSearch();
            alert('发布成功');
        }
    });
}


</script>