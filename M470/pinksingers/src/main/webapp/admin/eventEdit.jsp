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
<meta name=viewport content="width=device-width, initial-scale=1">
<script>
$(document).ready(function() {
	<c:forEach var="item" items="${event.register}">
		$("#status"+${item.member.memberId}).val('${item.attendance}');
	</c:forEach>
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
			<th colspan=2>Event Details</th>
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
	<c:if test="${not empty event.id}">
	<form action="/updateEventRegister" method="post" id="eventRegisterForm" name="eventRegisterForm">
		<table>
			<tr>
				<th colspan=3>Event Availability</th>
				<input type="hidden" name="eventId" value="${event.id}">
			</tr>
			<tr>
				<th>Name</th>
				<th>Section</th>
				<th>Status</th>
			</tr>
			<c:forEach var="item" items="${memberList}" varStatus="theCount">
  			<tr>
				<td>${item.firstName} ${item.lastName}</td>
				<input type=hidden name="memberId${theCount.count}" value="${item.memberId}">
				<td>${item.section} ${item.subSection}</td>
				<td>
					<select name="status${theCount.count}" id="status${item.memberId}">
						<option value="Available">Available</option>
						<option value="Not Available">Unvailable</option>
						<option value="Not Responded" selected>Not Responded</option>
					</select>
				</td>
			</tr>
			<c:set var="finalCount" value="${theCount.count}" />
			</c:forEach>
			<tr>
				<td>&nbsp;<input type="hidden" name="finalCount" value="${finalCount}"></td>
				<td colspan=2><input type="submit" value="Update"></td>
			</tr>
		</table>
		</form>
	</c:if>
  </div>
</div>
</body>
</html>