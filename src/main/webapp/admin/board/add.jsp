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
</head>
<body>
<form name="form1" method="post" class="definewidth m20">
<table class="table table-bordered table-hover m10">
	<tr>
        <td class="tableleft">父级</td>
        <td>
        	<select id="fid" name="fid">
        		<option value="">顶级</option>
                <c:forEach items="${modules}"  var="module">
        			<option value="${module.id}">${module.name}</option>
                </c:forEach>
        	</select>
        </td>
    </tr>
    <tr>
        <td class="tableleft">名称</td>
        <td><input type="text" name="name"/></td>
    </tr>
    <tr>
        <td class="tableleft">序号</td>
        <td><input type="text" name="orderx"/></td>
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
			window.location.href="list.jsp";
		 });
        var fid = getParam('fid');
        if(fid!=undefined || fid!=""){
    		$('#fid').val(fid);
    	}
    });

function save(){
    var a=$('form[name=form1]').serialize();
    YW.ajax({
        type: 'POST',
        url: '/leshi/c/admin/board/save',
        data:a,
        mysuccess: function(data){
            alert('发布成功');
        }
    });
}


</script>