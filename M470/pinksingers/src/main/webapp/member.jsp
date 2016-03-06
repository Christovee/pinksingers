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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
</head>
<body>
	<c:choose>
		<c:when test="${empty member.memberId}">
			<form action="/saveMember" method="post" id="memberForm" name="memberForm">
		</c:when>
		<c:otherwise>
			<form action="/updateMember" method="post" id="memberForm" name="memberForm">
		</c:otherwise>
	</c:choose>
		<c:if test="${status == 'updated'}">Changes has been saved<br/></c:if>
		<c:if test="${status == 'saved'}">Member has been added<br/></c:if>
		<input type="hidden" name="memberId" value="${member.memberId}">
		Name: <input type="text" id="name" name="name" value="${member.name}"><br/>
		Email: <input type="text" id="email" name="email" value="${member.email}"><br/>
		<input type="submit">
	</form>
</body>
</html>