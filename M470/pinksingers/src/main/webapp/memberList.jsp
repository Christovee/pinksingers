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
  			<jsp:include page="menu.jsp" />
  		</div>
  		<div class="col-9">
  			<div class="rTable"> 
  				<div class="rTableRow"> 
  					<div class="rTableHead">Name</div>
  					<div class="rTableHead">Section</div>
 				</div>
  				<c:forEach var="item" items="${memberList}">
  				<div class="rTableRow"> 
					<div class="rTableCell">
						<a href="/loadMember?memberId=${item.memberId}">${item.firstName}&nbsp;${item.lastName}</a>
					</div>
					<div class="rTableCell">
						<a href="/loadMember?memberId=${item.memberId}">${item.section}&nbsp;${item.subSection}</a>
					</div>
				</div>
			</c:forEach>
  		</div>
	</div>
</body>
</html>