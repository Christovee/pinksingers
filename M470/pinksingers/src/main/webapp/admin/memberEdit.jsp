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
	<c:if test="${status == 'updated'}"><div class="error">Changes have been saved</div></c:if>
	<c:if test="${status == 'saved'}"><div class="error">Member has been added</div></c:if>
	<form action="/${formAction}" method="post" id="memberForm" name="memberForm" class="rTable">
	<input type="hidden" name="memberId" value="${member.memberId}">
		<div class="rTableRow"> 
			<div class="rTableCell"><label>First Name</label></div>
			<div class="rTableCell"><input type="text" id="firstName" name="firstName" value="${member.firstName}"></div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell"><label>Last Name</label></div>
			<div class="rTableCell"><input type="text" id="lastName" name="lastName" value="${member.lastName}"></div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell"><label>Section</label></div>
			<div class="rTableCell">
				<select name="section" id="section">
					<option value="Soprano">Soprano</option>
					<option value="Alto">Alto</option>
					<option value="Tenor">Tenor</option>
					<option value="Bass">Bass</option>
				</select>
			</div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell"><label>Sub Section</label></div>
			<div class="rTableCell">
				<select name="subSection" id="subSection">
					<option value=1>1</option>
					<option value=2>2</option>
				</select>
			</div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell"><label>Email</label></div>
			<div class="rTableCell"><input type="text" id="email" name="email" value="${member.email}"></div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell"><label>Access Level</label></div>
			<div class="rTableCell">
				<select name="adminLevel" id="adminLevel">
					<option value="member">Member</option>
					<option value="sectionLeader">Section Leader</option>
					<option value="admin">Admin</option>
				</select>
			</div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell"><label>Status</label></div>
			<div class="rTableCell">
				<select name="status" id="status">
					<option value="Active">Active</option>
					<option value="Inactive">Inactive</option>
				</select>
			</div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell">&nbsp;</div>
			<div class="rTableCell"><input type="submit"></div>
		</div>
	</form>
	<c:if test="${not empty member.memberId}">
		<div class="rTable"> 
			<div class="rTableRow"> 
				<div class="rTableCell">
					<form action="/sendCreds" method="post" id="sendCreds" name="sendCreds">
						<input type="hidden" name="memberId" value="${member.memberId}">
						<input type="submit" value="Send Login Credentials">
					</form>
				</div>
			</div>
		</div>	
	</c:if>
  </div>
</div>
</body>
</html>