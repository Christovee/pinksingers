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
 	</div>
	<form name="profile" id="profile" method="post" action="updateMember?view=profile" class="rTable">
		<div class="rTableRow"> 
  			<div class="rTableCell">Email</div>
  			<div class="rTableCell"><input type="text" id="email" name="email" value="${member.email}"></div>
 		</div>
 		<div class="rTableRow"> 
  			<div class="rTableCell">Fun Fact</div>
  			<div class="rTableCell"><input type="text" id="funFact" name="funFact" value="${member.funFact}"></div>
 		</div>
 		<div class="rTableRow"> 
  			<div class="rTableCell"></div>
  			<div class="rTableCell"><button type="button" onclick="togglePassword()">Change Password</button></div>
 		</div>
 		<div class="rTableRow password"> 
  			<div class="rTableCell">Enter Password</div>
  			<div class="rTableCell"><input type="password" id="password" name="password"></div>
 		</div>
		<div class="rTableRow password"> 
  			<div class="rTableCell">Retype Password</div>
  			<div class="rTableCell"><input type="password" id="password2" name="password2"></div>
 		</div>
		<input type="hidden" name="memberId" id="memberId" value="${member.memberId}">
		<input type="hidden" name="action" id="action" value="editProfile">
		<div class="rTableRow"> 
  			<div class="rTableCell"></div>
  			<div class="rTableCell"><input type="submit" value="Save Changes"></div>
 		</div>
 		<div class="rTableRow"> 
  			<div class="rTableCell">Photo</div>
  			<div class="rTableCell"><img src="${servingUrl}" alt="profile photo"></div>
  		</div> 		
	</form>
	<form name="profilePhoto" id="profilePhoto" method="post" action="${uploadUrl}" enctype="multipart/form-data" class="rTable">
 		<div class="rTableRow"> 
  			<div class="rTableCell"><input type="file" name="profilePhoto" accept="image/*"></div>
 		</div>
		<input type="hidden" name="memberId" id="memberId" value="${member.memberId}">
 		<div class="rTableRow"> 
  			<div class="rTableCell"><input type="submit" value="Update Photo"></div>
 		</div>
 	</form>
  </div>
</div>
</body>
</html>