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
	<form action="/${formAction}" method="post" id="rehearsalForm" name="rehearsalForm">
		<c:if test="${status == 'updated'}">Changes have been saved<br/></c:if>
		<c:if test="${status == 'saved'}">Rehearsal has been added<br/></c:if>
		<input type="hidden" name="rehearsalId" value="${rehearsal.id}">
		<table>
		<tr>
			<th colspan=2>Rehearsal Details</th>
		</tr>
		<tr>
			<td><label>Season</label></td>
			<td><a href='loadSeason?seasonId=${season.id}'>${season.name}</a>
				<input type="hidden" name="seasonId" value="${season.id}">
			</td>
		</tr>
		<tr>
			<td><label>Rehearsal Name</label></td>
			<td><input type="text" id="rehearsalName" name="rehearsalName" value="${rehearsal.name}"></td>
		</tr>
		<tr>
			<td><label>Start Date</label></td>
			<td><input type="datetime-local" id="rehearsalStart" name="rehearsalStart" value="${rehearsal.start}"></td>
		</tr>
		<tr>
			<td><label>End Date</label></td>
			<td><input type="datetime-local" id="rehearsalEnd" name="rehearsalEnd" value="${rehearsal.end}"></td>
		</tr>
		<tr>
			<td><label>Location</label></td>
			<td><input type="input" id="location" name="location" value="${rehearsal.location}"></td>
		</tr>
		<tr>
			<td><label>Attendance Required</label></td>
			<td><input type="checkbox" id="attendanceRequired" name="attendanceRequired" value="true"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<c:choose>
			<c:when test="${empty rehearsal.id}">
				<td><input type="submit" value="Add rehearsal"></td>
			</c:when>
			<c:otherwise>
				<td>
					<input type="submit" value="Update rehearsal">
					<input type="button" value="Take Register" onclick="gotoRegister()">
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