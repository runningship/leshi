<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>乐事不动产</title>
<link rel="stylesheet" type="text/css" href="style/css.css" />
<link rel="stylesheet" type="text/css" href="style/cons.css" />
<script src="js/jquery-1.6.4.min.js"></script>
<script src='js/main.js'></script>
</head>

<body>

<div class="warp w_topLine"></div>

<jsp:include page="header.jsp" />

<div class="conWarp marginTop45">
  	
     <jsp:include page="left.jsp" />
     
     <div class="newsList">
     		<c:choose>
              <c:when test="${currentBoard!=null}">
                <h1 class="titH2"> <span>${currentBoard.name }</span></h1>
              </c:when>
              <c:otherwise>
                <h1 class="titH2"> <span>${topBoard.name }</span></h1>
              </c:otherwise>
            </c:choose>
            
          
          
          <ul class="ullistBox">
          	  <c:forEach items="${page.result}" var="news">
          	  	<li>
                   <div class="wenzi_003"></div>
                   <div class="wenzi_001 width368"><a target="_blank" href="./news.jsp?id=${news.id }" class="font_hui_14">${news.title }</a></div>
                   <div class="wenzi_002"><a target="_blank" href="./news.jsp" class="font_hui_12">
                   	<fmt:formatDate value="${news.addtime}" pattern="yyyy-MM-dd"/>
                   </a></div>
              </li>
          	  </c:forEach>
          </ul>
          
          <div class="listPage">
                                    
			<div id="paginator" class="pagination">
				<c:choose>
					<c:when test="${page.currentPageNo==1}">
						<span class="prev"><b>&lt;</b>上一页</span>
					</c:when>
					<c:otherwise>
						<a title="上一页"  class="btn-s prev"  href="newsList.jsp?topId=${topBoard.id }&bid=${currentBoard.id }&currentPageNo=${page.currentPageNo-1}"><b>&lt;</b>上一页</a>
					</c:otherwise>
				</c:choose>
				
				<c:forEach var="i"  begin="1"  end="5"  step="1">
					<c:if test="${page.currentPageNo-(6-i)>0}">
						<a pagetag="go" href="newsList.jsp?topId=${topBoard.id }&bid=${currentBoard.id }&currentPageNo=${page.currentPageNo-(6-i) }">${page.currentPageNo-(6-i) }</a>
					</c:if>
			    </c:forEach>
			    <span class="cur">${page.currentPageNo}</span>
				<c:forEach var="j"  begin="1"  end="5"  step="1">
					<c:if test="${page.currentPageNo+j<=page.totalPageCount}">
						<a pagetag="go"  href="newsList.jsp?topId=${topBoard.id }&bid=${currentBoard.id }&currentPageNo=${page.currentPageNo+j}">${page.currentPageNo+j }</a>
					</c:if>
			    </c:forEach>
			    
			    <c:choose>
					<c:when test="${page.currentPageNo==page.totalPageCount}">
						<span class="prev">下一页<b>&gt;</b></span>
					</c:when>
					<c:otherwise>
						<a title="下一页" class="btn-s next" href="newsList.jsp?topId=${topBoard.id }&bid=${currentBoard.id }&currentPageNo=${page.currentPageNo+1}">下一页<b>&gt;</b></a>
					</c:otherwise>
				</c:choose>
				
				
			</div>
          </div>   
     
     </div>
    

</div>

<jsp:include page="footer.jsp" />

</body>
</html>
