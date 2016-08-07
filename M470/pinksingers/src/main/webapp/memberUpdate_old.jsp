<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.project.pinksingers.Member" %>
<%@ page import="com.googlecode.objectify.Key" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<link type="text/css" rel="stylesheet" href="stylesheet/main.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script>
$(document).ready(function() {
	//Hide password fields when page loads
	$(".password").hide();
});

function togglePassword()
{
	$(".password").toggle();
}
</script>
<meta name=viewport content="width=device-width, initial-scale=1">
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
	<form name="profile" id="profile" method="post" action="updateMember?view=profile">
	<tr>
			<td><label>Email</label></td>
			<td><input type="text" id="email" name="email" value="${member.email}"></td>
	</tr>
	<tr>
		<td><label>Fun Fact</label></td>
		<td><input type="text" id="funFact" name="funFact" value="${member.funFact}"></td>
	</tr>
	<tr>
		<td colspan=2><button type="button" onclick="togglePassword()">Change Password</button></td>
	</tr>
	<tr class="password">
		<td><label>Enter Password</label></td>
		<td><input type="password" id="password" name="password"></td>
	</tr>
	<tr class="password">
		<td><label>Retype Password</label></td>
		<td><input type="password" id="password2" name="password2"></td>
	</tr>
	<tr>
			<td><input type="hidden" name="memberId" id="memberId" value="${member.memberId}">
			<input type="hidden" name="action" id="action" value="editProfile"></td>
			<td><input type="submit" value="Save Changes"></td>
	</tr>
	</form>
	<form name="profilePhoto" id="profilePhoto" method="post" action="${uploadUrl}" enctype="multipart/form-data">
	<tr>
		<td><label>Photo</label></td>
		<td><img src="${servingUrl}" alt="profile photo"></td>
	</tr>
	<tr>
		<td colspan=2>
			<input type="file" name="profilePhoto" accept="image/*" capture="camera">
			<input type="hidden" name="memberId" id="memberId" value="${member.memberId}">
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="Update Photo"></td>
	</tr>
	</form>
	</table>
  </div>
</div>
</body>
</html>