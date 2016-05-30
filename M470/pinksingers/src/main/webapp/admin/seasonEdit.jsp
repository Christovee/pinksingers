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
<link type="text/css" rel="stylesheet" href="../stylesheet/main.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script>
$(document).ready(function() {
	
});


</script>
</head>
<body>
	<div class="header"></div>
<div class="row">
  <div class="col-3 menu">
  <ul>
	<jsp:include page="../menu.jsp" />
  </ul>
  </div>
  <div class="col-9">
  <c:choose>
		<c:when test="${empty season.seasonId}">
			<c:set var="formAction" value="saveSeason"/>
		</c:when>
		<c:otherwise>
			<c:set var="formAction" value="updateSeason"/>
		</c:otherwise>
	</c:choose>
	<form action="/${formAction}" method="post" id="seasonForm" name="seasonForm">
		<c:if test="${status == 'updated'}">Changes have been saved<br/></c:if>
		<c:if test="${status == 'saved'}">Season has been added<br/></c:if>
		<input type="hidden" name="seasonId" value="${season.seasonId}">
		<table>
		<tr>
			<td><label>Season Name</label></td>
			<td><input type="text" id="seasonName" name="seasonName" value="${season.seasonName}"></td>
		</tr>
		<tr>
			<td><label>Concert Title</label></td>
			<td><input type="text" id="concertTitle" name="concertTitle" value="${season.concertTitle}"></td>
		</tr>
		<tr>
			<td><label>Start Date</label></td>
			<td><input type="date" id="seasonStart" name="seasonStart" value="${season.seasonStart}"></td>
		</tr>
		<tr>
			<td><label>End Date</label></td>
			<td><input type="date" id="seasonEnd" name="seasonEnd" value="${season.seasonEnd}"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<c:choose>
			<c:when test="${empty season.seasonId}">
				<td><input type="submit" value="Add season"></td>
			</c:when>
			<c:otherwise>
				<td><input type="submit" value="Update season"></td>
			</c:otherwise>
			</c:choose>	
		</tr>
	</form>
	</table>
  </div>
</div>
</body>
</html>