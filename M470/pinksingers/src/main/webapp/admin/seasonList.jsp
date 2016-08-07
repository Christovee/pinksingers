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
  	<div class="rTable"> 
  		<div class="rTableRow">
  			<div class="rTableHead">Season Name</div>
  			<div class="rTableHead">Concert Title</div>
  			<div class="rTableHead">Dates</div>
  			<div class="rTableHead"></div>
 		</div>
  		<c:forEach var="season" items="${seasonList}">
  			<div class="rTableRow">
  				<div class="rTableCell"><a href='loadSeason?seasonId=${season.id}'>${season.name}</a></div>
				<div class="rTableCell"><a href='loadSeason?seasonId=${season.id}'>${season.concertTitle}</a></div>
				<div class="rTableCell">
					<a href='loadSeason?seasonId=${season.id}'>
						<fmt:formatDate type="date" value="${season.javaStart}" /> - 
						<fmt:formatDate type="date" value="${season.javaEnd}" />
					</a>
				</div>
				<c:if test="${season.currentSeason}">
					<div class='rTableCell'><div class='dot' style='background: green'></div></div>
				</c:if>
				<c:if test="${not season.currentSeason}">
					<div class='rTableCell'><div class='dot' style='background: white'></div></div>
				</c:if>
			</div>
		</c:forEach>
  	</div>
  </div>
</div>
</body>
</html>