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
 	</tr>
  	<c:forEach var="item" items="${seasonList}">
  		<tr>
			<td><a href="loadSeason?seasonId=${item.seasonId}">${item.seasonName}</a></td>
			<td><a href="loadSeason?seasonId=${item.seasonId}">${item.concertTitle}</a></td>
			<td><a href="loadSeason?seasonId=${item.seasonId}">${item.seasonStart} - ${item.seasonEnd}</a></td>
	</c:forEach>
  	</table>
  </div>
</div>
</body>
</html>