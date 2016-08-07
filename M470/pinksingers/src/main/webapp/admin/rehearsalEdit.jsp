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
<meta name=viewport content="width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script>
$(document).ready(function() {
	
	if(${rehearsal.attendanceRequired == true})
	{
		$("#attendanceRequired").prop('checked', true);
	}
	
});

function gotoRegister()
{
	window.location.replace("loadRehearsal?rehearsalId="+${rehearsal.id}+"&seasonId="+${season.id}+"&register=true");
}

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
		<c:when test="${empty rehearsal.id}">
			<c:set var="formAction" value="saveRehearsal"/>
		</c:when>
		<c:otherwise>
			<c:set var="formAction" value="updateRehearsal"/>
		</c:otherwise>
	</c:choose>
	<c:if test="${status == 'updated'}"><div class="error">Changes have been saved</div></c:if>
	<c:if test="${status == 'saved'}"><div class="error">Rehearsal has been added</div></c:if>
	<div class="title">Rehearsal Details</div>
	<form action="/${formAction}" method="post" id="rehearsalForm" name="rehearsalForm" class="rTable"> 
	<input type="hidden" name="rehearsalId" value="${rehearsal.id}">
		<div class="rTableRow">
			<div class="rTableCell"><label>Season</label></div>
			<div class="rTableCell"><a href='loadSeason?seasonId=${season.id}'>${season.name}</a>
				<input type="hidden" name="seasonId" value="${season.id}">
			</div>
		</div>
		<div class="rTableRow">
			<div class="rTableCell"><label>Rehearsal Name</label></div>
			<div class="rTableCell"><input type="text" id="rehearsalName" name="rehearsalName" value="${rehearsal.name}"></div>
		</div>
		<div class="rTableRow">
			<div class="rTableCell"><label>Start Date</label></div>
			<div class="rTableCell"><input type="datetime-local" id="rehearsalStart" name="rehearsalStart" value="${rehearsal.start}"></div>
		</div>
		<div class="rTableRow">
			<div class="rTableCell"><label>End Date</label></div>
			<div class="rTableCell"><input type="datetime-local" id="rehearsalEnd" name="rehearsalEnd" value="${rehearsal.end}"></div>
		</div>
		<div class="rTableRow">
			<div class="rTableCell"><label>Location</label></div>
			<div class="rTableCell"><input type="text" id="location" name="location" value="${rehearsal.location}"></div>
		</div>
		<div class="rTableRow">
			<div class="rTableCell"><label>Attendance Required</label></div>
			<div class="rTableCell"><input type="checkbox" id="attendanceRequired" name="attendanceRequired" value="true"></div>
		</div>
		<div class="rTableRow">
			<div class="rTableCell">&nbsp;</div>
			<c:choose>
			<c:when test="${empty rehearsal.id}">
				<div class="rTableCell"><input type="submit" value="Add rehearsal"></div>
			</c:when>
			<c:otherwise>
				<div class="rTableCell">
					<input type="submit" value="Update rehearsal">
					<input type="button" value="Take Register" onclick="gotoRegister()">
				</div>
			</c:otherwise>
			</c:choose>	
		</div>
	</form>
  </div>
</div>
</body>
</html>