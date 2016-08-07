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
	<div class="title">Event Details</div>
	<form action="/${formAction}" method="post" id="eventForm" name="eventForm" class="rTable">
		<input type="hidden" name="eventId" value="${event.id}">
		<c:if test="${status == 'updated'}"><div>Changes have been saved</div></c:if>
		<c:if test="${status == 'saved'}"><div>Event has been added</div></c:if>
		<div class="rTableRow"> 
			<div class="rTableCell">Event Name</div>
			<div class="rTableCell"><input type="text" id="eventName" name="eventName" value="${event.name}"></div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell">Start Date</div>
			<div class="rTableCell"><input type="datetime-local" id="eventStart" name="eventStart" value="${event.start}"></div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell">End Date</div>
			<div class="rTableCell"><input type="datetime-local" id="eventEnd" name="eventEnd" value="${event.end}"></div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell">Location</div>
			<div class="rTableCell"><input type="text" id="location" name="location" value="${event.location}"></div>
		</div>
		<div class="rTableRow"> 
			<c:choose>
			<c:when test="${empty event.id}">
				<div class="rTableCell"><input type="submit" value="Add event"></div>
			</c:when>
			<c:otherwise>
				<div class="rTableCell"><input type="submit" value="Update event"></div>
			</c:otherwise>
			</c:choose>
			<c:choose>
			<c:when test="${empty event.id}">
				<div class="rTableCell"><input type="submit" value="Add event"></div>
			</c:when>
			<c:otherwise>
				<div class="rTableCell"><input type="submit" value="Update event"></div>
			</c:otherwise>
			</c:choose>	
		</div>
	</form>
	<c:if test="${not empty event.id}">
		<div class="title">Event Availability</div>
		<form action="/updateEventRegister" method="post" id="eventRegisterForm" name="eventRegisterForm" class="rTable">
		<input type="hidden" name="eventId" value="${event.id}">
		<input type="hidden" name="finalCount" value="${finalCount}">
			<div class="rTableRow"> 
				<div class="rTableHead">Name</div>
				<div class="rTableHead">Section</div>
				<div class="rTableHead">Status</div>
			</div>
			<c:forEach var="item" items="${memberList}" varStatus="theCount">
				<input type=hidden name="memberId${theCount.count}" value="${item.memberId}">
  				<div class="rTableRow"> 
					<div class="rTableCell">${item.firstName} ${item.lastName}</div>
					<div class="rTableCell">${item.section} ${item.subSection}</div>
					<div class="rTableCell">
						<select name="status${theCount.count}" id="status${item.memberId}">
							<option value="Available">Available</option>
							<option value="Not Available">Unvailable</option>
							<option value="Not Responded" selected>Not Responded</option>
						</select>
					</div>
				</div>
				<c:set var="finalCount" value="${theCount.count}" />
			</c:forEach>
			<div class="rTableRow"> 
				<div class="rTableCell"><input type="submit" value="Update"></div>
			</div>
		</form>
	</c:if>
  </div>
</div>
</body>
</html>