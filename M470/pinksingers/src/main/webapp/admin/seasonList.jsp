<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.project.pinksingers.Member" %>
<%@ page import="com.googlecode.objectify.Key" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link type="text/css" rel="stylesheet" href="stylesheet/main.css"/>
<meta name=viewport content="width=device-width, initial-scale=1">
</head>
<body>
<div class="header"></div>
<div class="row">
  <div class="col-3 menu">
  	<jsp:include page="../menu.jsp" />
  </div>
  <div class="col-9">
  	<table>
  	<tr>
  		<th>Season Name</th>
  		<th>Concert Title</th>
  		<th>Dates</th>
  		<th><th>
 	</tr>
  	<c:forEach var="season" items="${seasonList}">
  		<tr>
  			<td><a href='loadSeason?seasonId=${season.id}'>${season.name}</a></td>
			<td><a href='loadSeason?seasonId=${season.id}'>${season.concertTitle}</a></td>
			<td><a href='loadSeason?seasonId=${season.id}'><fmt:formatDate type="date" 
            value="${season.javaStart}" /> - <fmt:formatDate type="date" 
            value="${season.javaEnd}" /></td>
			<c:if test="${season.currentSeason}">
				<td><div class='dot' style='background: green'></div></td></tr>
			</c:if>
			<c:if test="${not season.currentSeason}">
				<td><div class='dot' style='background: white'></div></td></tr>
			</c:if>
		</tr>
	</c:forEach>
  	</table>
  </div>
</div>
</body>
</html>