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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
</head>
<body>
	<div class="header"></div>
<div class="row">
  <div class="col-3 menu">
  	<jsp:include page="menu.jsp" />
  </div>
  <div class="col-9">
	<table>
	<tr>
		<td><label>First Name</label></td>
		<td>${member.firstName}</td>
	</tr>
	<tr>
		<td><label>Last Name</label></td>
		<td>${member.lastName}</td>
	</tr>
	<tr>
		<td><label>Section</label></td>
		<td>${member.section}&nbsp;${member.subSection}</td>
	</tr>
	<tr>
		<td><label>Email</label></td>
		<td>${member.email}</td>
	</tr>
	<tr>
		<td><label>Fun Fact</label></td>
		<td>${member.funFact}</td>
	</tr>
	<tr>
		<td><label>Photo</label></td>
		<td><img src="${servingUrl}" alt="profile photo"></td>
	</tr>
	<c:if test="${member.memberId == sessionMemberId}">
		<form action="/loadMember" method="post">
		<tr>
			<td>
				<input type="hidden" name="memberId" id="memberId" value="${member.memberId}">
				<input type="hidden" name="action" id="action" value="editProfile">
			</td>
			<td><input type="submit" value="Edit Profile"></td>
		</tr>
		</form>
	</c:if>
	</table>
  </div>
</div>
</body>
</html>