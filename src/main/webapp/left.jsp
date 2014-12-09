<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="daohang_2">
    <div class="bordersolid"><span class="font_lan">${topBoard.name }</span></div>
    <c:forEach items="${boards}"  var="board">
      <div class="daohang_title margintop15">
        <a href="newsList.jsp?topId=${topBoard.id }&bid=${board.id}">
          <div class="jiantou"><img border="0" src="images/jiantou.png"></div>
            <c:choose>
              <c:when test="${board.id==currentBoard.id}">
                <span id="qydtmark" class="f_yh14 current">${board.name }</span>
              </c:when>
              <c:otherwise>
                <span id="qydtmark" class="f_yh14">${board.name }</span>
              </c:otherwise>
            </c:choose>
        </a>
      </div>
    </c:forEach>
</div>

