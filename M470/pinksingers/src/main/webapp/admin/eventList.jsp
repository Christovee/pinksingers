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
<meta name=viewport content="width=device-width, initial-scale=1">
</head>
<body>
<div class="header"></div>
<div class="row">
  <div class="col-3 menu">
  	<jsp:include page="../menu.jsp" />
  </div>
  <div class="col-9">
  	<div class="rTableRow"> 
  	<div class="rTableRow"> 
  		<div class="rTableHead">Event Name</div>
  		<div class="rTableHead">Location</div>
  		<div class="rTableHead">Dates</div>
  	</div>
  	<c:forEach var="event" items="${eventList}">
  		<div class="rTableRow"> 
  			<div class="rTableCell"><a href='loadEvent?eventId=${event.id}'>${event.name}</a></div>
			<div class="rTableCell"><a href='loadEvent?eventId=${event.id}'>${event.location}</a></div>
			<div class="rTableCell"><a href='loadEvent?eventId=${event.id}'><fmt:formatDate type="date" 
            value="${event.javaStart}" /></a></div>
		</div>
	</c:forEach>
  	</div>
  </div>
</div>
</body>
</html>