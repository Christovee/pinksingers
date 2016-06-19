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
	$("#key").hide();
	//Default each member to present. 
	<c:forEach var="sm" items="${season.seasonMembers}">
		$("#present"+${sm.member.memberId}).prop('checked', true);
	</c:forEach>
	
	//Update each member if register already taken
	<c:forEach var="reg" items="${rehearsal.register}">
		switch("${reg.attendance}")
		{
			case "present":
				$("#present"+${reg.member.memberId}).prop('checked', true);
			break;
			case "apologies":
				$("#apologies"+${reg.member.memberId}).prop('checked', true);
			break;
			case "absent":
				$("#absent"+${reg.member.memberId}).prop('checked', true);
			break;
			case "most":
				$("#most"+${reg.member.memberId}).prop('checked', true);
			break;
			case "part":
				$("#part"+${reg.member.memberId}).prop('checked', true);
		}
	</c:forEach>
});

function toggleKey()
{
	$("#key").toggle();	
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
  <input type="button" value="View/Hide Key" onclick="toggleKey()">
  <div id="key">
  	Key:<br/> 
  	/ = Present <br/> 
  	O = Apologies <br/> 
  	X = Absent (no apologies)<br/>  
  	M = Most <br/> 
  	P = Part<br/> 
  </div>
  <form action="saveRegister" method="post" name="register">
  <table>
  <tr>
  	<th><label>Name</label></th>
  	<th><label>Section</label></th>
  	<th><label>/</label></th>
  	<th><label>O</label></th>
  	<th><label>X</label></th>
  	<th><label>M</label></th>
  	<th><label>P</label></th>
  </tr>
  <c:forEach var="sm" items="${season.seasonMembers}" varStatus="theCount">
  	<tr>
  		<td>
  			${sm.member.firstName} ${sm.member.lastName}
  			<input type="hidden" name="memberId${theCount.count}" value="${sm.member.memberId}">
  		</td>
  		<td>${sm.member.section} ${sm.member.subSection}</td>
  		<td><input type="radio" id="present${sm.member.memberId}" name="attendance${theCount.count}" value="present"></td>
  		<td><input type="radio" id="apologies${sm.member.memberId}" name="attendance${theCount.count}" value="apologies"></td>
  		<td><input type="radio" id="absent${sm.member.memberId}" name="attendance${theCount.count}" value="absent"></td>
  		<td><input type="radio" id="most${sm.member.memberId}" name="attendance${theCount.count}" value="most"></td>
  		<td><input type="radio" id="part${sm.member.memberId}" name="attendance${theCount.count}" value="part"></td>
  	</tr>	
  	<c:set var="finalCount" value="${theCount.count}" />
  </c:forEach>
  <tr>
  	<td>
  		<input type="hidden" name="rehearsalId" value="${rehearsal.rehearsalId}">
  		<input type="hidden" name="finalCount" value="${finalCount}">
  		<input type="hidden" name="seasonId" value="${season.seasonId}"> 
  	</td>
  	<td colspan=6><input type="submit" value="Save Register"></td>
  </table>
  </form>
  </div>
</div>
</body>
</html>