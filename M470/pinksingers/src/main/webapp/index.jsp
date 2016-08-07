<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link type="text/css" rel="stylesheet" href="stylesheet/main.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script>
function sendApologies()
{
	window.location.replace("sendApologies?rehearsalId="+${rehearsal.id}+"&memberId="+${sessionMemberId});
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
  <div class="col-3">
  	<div>Welcome ${sessionFirstName}</div>
  	<div class="rTable"> 
  		<div class="rTableRow"> 
  			<div class="rTableHead">Current Season</div>
  			<div class="rTableCell">${season.name}</div>
 		</div>
 	</div>
 </div>
 <div class="col-3">
 	<div class="rTable"> 
  		<div class="rTableRow"> 
  			<div class="rTableHead">Next Rehearsal</div>
  			<div class="rTableCell">${rehearsal.name}</div>
 		</div>
 		<div class="rTableRow"> 
  			<div class="rTableHead">Start</div>
  			<div class="rTableCell"><fmt:formatDate type="both" value="${rehearsal.javaStart}" /></div>
 		</div>
 		<div class="rTableRow"> 
  			<div class="rTableHead">End</div>
  			<div class="rTableCell"><fmt:formatDate type="both" value="${rehearsal.javaEnd}" /></div>
 		</div>
 		<div class="rTableRow"> 
  			<div class="rTableHead">Location</div>
  			<div class="rTableCell">${rehearsal.location}</div>
 		</div>
 		<div class="rTableRow"> 
  			<div class="rTableHead">Apologies Sent</div>
  			<div class="rTableCell">${rehearsalAttendance}</div>
 		</div>
 		<div class="rTableRow"> 
  			<div class="rTableHead"></div>
  			<div class="rTableCell"><button onclick="sendApologies()">Send Apologies</button></div>
 		</div>
 	</div>
 </div>
 <div class="col-3">
  	Next Event: ${event.name} <br/>
 </div>
</div>
</body>
</html>