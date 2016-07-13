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
	
	// May be able to delete this. 
	
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
		<c:when test="${empty event.id}">
			<c:set var="formAction" value="saveEvent"/>
		</c:when>
		<c:otherwise>
			<c:set var="formAction" value="updateEvent"/>
		</c:otherwise>
	</c:choose>
	<form action="/${formAction}" method="post" id="eventForm" name="eventForm">
		<c:if test="${status == 'updated'}">Changes have been saved<br/></c:if>
		<c:if test="${status == 'saved'}">Event has been added<br/></c:if>
		<input type="hidden" name="eventId" value="${event.id}">
		<table>
		<tr>
			<th colspan=2>Even Details</th>
		</tr>
		<tr>
			<td><label>Event Name</label></td>
			<td><input type="text" id="eventName" name="eventName" value="${event.name}"></td>
		</tr>
		<tr>
			<td><label>Start Date</label></td>
			<td><input type="datetime-local" id="eventStart" name="eventStart" value="${event.start}"></td>
		</tr>
		<tr>
			<td><label>End Date</label></td>
			<td><input type="datetime-local" id="eventEnd" name="eventEnd" value="${event.end}"></td>
		</tr>
		<tr>
			<td><label>Location</label></td>
			<td><input type="text" id="location" name="location" value="${event.location}"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<c:choose>
			<c:when test="${empty event.id}">
				<td><input type="submit" value="Add event"></td>
			</c:when>
			<c:otherwise>
				<td>
					<input type="submit" value="Update event">
				</td>
			</c:otherwise>
			</c:choose>	
		</tr>
	</form>
	</table>
  </div>
</div>
</body>
</html>