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
	<c:forEach var="item" items="${memberList}">
		$("#section"+${item.memberId}).val('${item.section}');
		$("#subSection"+${item.memberId}).val('${item.subSection}');
		$("#status"+${item.memberId}).val('${item.status}');
	</c:forEach>
	
	if(${season.currentSeason == true})
	{
		$("#currentSeason").prop('checked', true);
		$("#isCurrentSeason").val("true");
	}else{
		$("#isCurrentSeason").val("false");
	}
	
	<c:forEach var="item" items="${seasonMembers}">
		$("#"+${item.memberId}).css('background', 'green');
		$("#section"+${item.memberId}).val('${item.seasonSection}');
		$("#subSection"+${item.memberId}).val('${item.seasonSubSection}');
		$("#status"+${item.memberId}).val('${item.seasonStatus}');
	</c:forEach>
	
	//Register handler to update the hidden field on seasonMembers form
	$('#currentSeason').change(function() {
		   if($(this).is(":checked")) {
			   $("#isCurrentSeason").val("true");
		      return;
		   }
		   $("#isCurrentSeason").val("false");
	});
	
	
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
			<th colspan=2>Season Details</th>
		</tr>
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
			<td><label>Current Season?</label></td>
			<td><input type="checkbox" id="currentSeason" name="currentSeason" value="true"></td>
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
	<c:if test="${not empty season.seasonId}">
		<form action="/updateSeasonMembers" method="post" id="seasonMemberForm" name="seasonMemberForm">
		<table>
			<tr>
				<th colspan=4>Season Member Details</th>
				<input type="hidden" name="seasonId" value="${season.seasonId}">
				<input type="hidden" name="isCurrentSeason" id="isCurrentSeason">
			</tr>
			<tr>
				<th></th>
				<th>Name</th>
				<th>Section</th>
				<th>Status</th>
			</tr>
			<c:forEach var="item" items="${memberList}" varStatus="theCount">
  			<tr>
  				<td>
					<div id="${item.memberId}" class="dot" style="background: red"></div>
				</td>
				<td>${item.firstName} ${item.lastName}</td>
				<input type=hidden name="memberId${theCount.count}" value="${item.memberId}">
				<td>
					<select name="section${theCount.count}" id="section${item.memberId}">
						<option value="Soprano">Soprano</option>
						<option value="Alto">Alto</option>
						<option value="Tenor">Tenor</option>
						<option value="Bass">Bass</option>
					</select>
					<select name="subSection${theCount.count}" id="subSection${item.memberId}">
						<option value=1>1</option>
						<option value=2>2</option>
					</select>
				</td>
				<td>
					<select name="status${theCount.count}" id="status${item.memberId}">
						<option value="Active">Active</option>
						<option value="Resting">Resting</option>
						<option value="Parental Leave">Parental leave</option>
						<option value="Dropped Out (EC)">Dropped Out (EC)</option>
						<option value="Dropped Out">Dropped Out</option>
						<option value="Inactive">Inactive</option>
					</select>
				</td>
			</tr>
			<c:set var="finalCount" value="${theCount.count}" />
			</c:forEach>
			<tr>
				<td>&nbsp;<input type="hidden" name="finalCount" value="${finalCount}"></td>
				<td colspan=2><input type="submit" value="submit"></td>
			</tr>
		</table>
		</form>
	</c:if>
  </div>
</div>
</body>
</html>