<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>文章管理</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap.css" />
    <link rel="stylesheet" type="text/css" href="../Css/bootstrap-responsive.css" />
    <link rel="stylesheet" type="text/css" href="../Css/style.css" />
    <script type="text/javascript" src="../Js/jquery.js"></script>
    <script type="text/javascript" src="../Js/bootstrap.js"></script>
    <script type="text/javascript" src="../Js/ckform.js"></script>
    <script type="text/javascript" src="../Js/common.js"></script>
    <script type="text/javascript" src="../Js/pagination.js"></script>
    
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
function doSearch(){
	var a=$('form[name=form1]').serialize();
	YW.ajax({
	    type: 'get',
	    url: '/leshi/c/admin/post/listData',
	    data: a,
	    mysuccess: function(json){
	        buildHtmlWithJsonArray("repeat",json['data']);
	        Page.setPageInfo(json);
	    }
	  });
}
	function delPost(id){
		art.dialog.confirm('删除后不可恢复，确定要删除吗？', function () {
		    YW.ajax({
		        type: 'POST',
		        url: '/leshi/c/admin/post/delete?id='+id,
		        data:'',
		        mysuccess: function(data){
                    doSearch();
		            alert('删除成功');
		        }
		      });
		  },function(){},'warning');
	}
	$(function () {
		Page.Init();
		$('#addnew').click(function(){
				window.location.href="add.jsp";
		 });
		doSearch();
	});
	
</script>
</head>
<body>
<form class="form-inline definewidth m20" name="form1"  method="get" onsubmit="return false;">
    <button type="button" class="btn btn-success" id="addnew">新增文章</button>
    <button type="button" class="btn btn-success btn_subnmit hidden" onclick="doSearch();return false;">搜索</button>
</form>

<table class="table table-bordered table-hover definewidth m10">
    <thead>
    <tr>
    	<th>编号</th>
        <th>序号</th>
        <th>栏目名称</th>
        <th>标题</th>
        <th>管理操作</th>
    </tr>
    </thead>
    <tbody>
    	<tr style="display:none" class="repeat">
    			<td>$[id]</td>
                <td>$[orderx]</td>
                <td>$[bname]</td>
                <td>$[title]</td>
                <td><a href="edit.jsp?id=$[id]">编辑</a>
                    <a href="#" onclick="delPost($[id])">删除</a>
                </td>
            </tr>
    </tbody>
	</table>

	<div class="footer" style="margin-top:5px;margin-left:35px;">
        <div class="maxHW mainCont ymx_page foot_page_box"></div>
    </div>
</body>
</html>
