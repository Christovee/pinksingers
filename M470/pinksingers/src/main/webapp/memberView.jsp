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
<meta name=viewport content="width=device-width, initial-scale=1">
</head>
<body>
	<div class="header"></div>
<div class="row">
  <div class="col-3 menu">
  	<jsp:include page="menu.jsp" />
  </div>
  <div class="col-9">
	<div class="rTable"> 
		<div class="rTableRow"> 
			<div class="rTableCell">First Name</div>
			<div class="rTableCell">${member.firstName}</div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell">Last Name</div>
			<div class="rTableCell">${member.lastName}</div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell">Section</div>
			<div class="rTableCell">${member.section}&nbsp;${member.subSection}</div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell">Email</div>
			<div class="rTableCell">${member.email}</div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell">Fun Fact</div>
			<div class="rTableCell">${member.funFact}</div>
		</div>
		<div class="rTableRow"> 
			<div class="rTableCell">Photo</div>
			<div class="rTableCell"><img src="${servingUrl}" alt="profile photo"></div>
		</div>
	
	</div>
	<c:if test="${member.memberId == sessionMemberId}">
		<form action="/loadMember" method="post" class="rTable">
			<input type="hidden" name="memberId" id="memberId" value="${member.memberId}">
			<input type="hidden" name="action" id="action" value="editProfile">
			<div class="rTableRow"> 
				<div class="rTableCell"><input type="submit" value="Edit Profile"></div>
				<div class="rTableCell"></div>
			</div>
		</form>
	</c:if>
	<c:if test="${sessionAccess == 'admin'}">
		<form action="/loadMember" method="post" class="rTable">
			<input type="hidden" name="memberId" id="memberId" value="${member.memberId}">
			<input type="hidden" name="action" id="action" value="editMember">
			<div class="rTableRow"> 
				<div class="rTableCell"><input type="submit" value="Edit Member"></div>
				<div class="rTableCell"></div>
			</div>
		</form>
	</c:if>
  </div>
</div>
</body>
</html>