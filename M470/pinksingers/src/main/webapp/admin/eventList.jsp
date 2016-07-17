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
  	<table>
  	<tr>
  		<th>Event Name</th>
  		<th>Location</th>
  		<th>Dates</th>
  	</tr>
  	<c:forEach var="event" items="${eventList}">
  		<tr>
  			<td><a href='loadEvent?eventId=${event.id}'>${event.name}</a></td>
			<td><a href='loadEvent?eventId=${event.id}'>${event.location}</a></td>
			<td><a href='loadEvent?eventId=${event.id}'>${event.start} - ${event.end}</a></td>
		</tr>
	</c:forEach>
  	</table>
  </div>
</div>
</body>
</html>