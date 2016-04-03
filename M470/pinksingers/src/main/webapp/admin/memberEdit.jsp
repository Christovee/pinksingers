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
	$("#section").val('${member.section}');
	$("#subSection").val('${member.subSection}');
	$("#adminLevel").val('${member.adminLevel}');
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
		<c:when test="${empty member.memberId}">
			<c:set var="formAction" value="saveMember"/>
		</c:when>
		<c:otherwise>
			<c:set var="formAction" value="updateMember"/>
		</c:otherwise>
	</c:choose>
	<form action="/${formAction}" method="post" id="memberForm" name="memberForm">
		<c:if test="${status == 'updated'}">Changes have been saved<br/></c:if>
		<c:if test="${status == 'saved'}">Member has been added<br/></c:if>
		<input type="hidden" name="memberId" value="${member.memberId}">
		<table>
		<tr>
			<td><label>First Name</label></td>
			<td><input type="text" id="firstName" name="firstName" value="${member.firstName}"></td>
		</tr>
		<tr>
			<td><label>Last Name</label></td>
			<td><input type="text" id="lastName" name="lastName" value="${member.lastName}"></td>
		</tr>
		<tr>
			<td><label>Section</label></td>
			<td>
				<select name="section" id="section">
					<option value="Soprano">Soprano</option>
					<option value="Alto">Alto</option>
					<option value="Tenor">Tenor</option>
					<option value="Bass">Bass</option>
				</select>
			</td>
		</tr>
		<tr>
			<td><label>Sub Section</label></td>
			<td>
				<select name="subSection" id="subSection">
					<option value=1>1</option>
					<option value=2>2</option>
				</select>
			</td>
		</tr>
		<tr>
			<td><label>Email</label></td>
			<td><input type="text" id="email" name="email" value="${member.email}"></td>
		</tr>
		<tr>
			<td><label>Access Level</label></td>
			<td>
				<select name="adminLevel" id="adminLevel">
					<option value="member">Member</option>
					<option value="sectionLeader">Section Leader</option>
					<option value="admin">Admin</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit"></td>
		</tr>
	</form>
	<c:if test="${not empty member.memberId}">
		<tr>
			<td>&nbsp;</td>
			<td>
				<form action="/sendCreds" method="post" id="sendCreds" name="sendCreds">
					<input type="hidden" name="memberId" value="${member.memberId}">
					<input type="submit" value="Send Login Credentials">
				</form>
			</td>
		</tr>
	</c:if>
	</table>
  </div>
</div>
</body>
</html>