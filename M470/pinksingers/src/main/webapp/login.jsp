<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
  				<ul>
					<li><a href="login.jsp">Login</a></li>
  				</ul>
  		</div>
  		<div class="col-9">
  			<form action="/login" method="post" name="login" id="login">
  				<div class="rTable"> 
  					<c:if test="${status == 'userName'}">
  						<div class="rTableRow"> 
	 						<div class="rTableCell">Email is not recognised</div> 
	 					</div> 
  					</c:if>
  					<c:if test="${status == 'password'}">
  						<div class="rTableRow"> 
	 						<div class="rTableCell">Password is incorrect</div> 
	 					</div> 
  					</c:if>
  					<div class="rTableRow"> 
  						<div class="rTableCell">Email</div> 
  						<div class="rTableCell"><input type="email" name="email" id="email"></div> 
	 				</div> 
	 				<div class="rTableRow"> 
	 					<div class="rTableCell">Password</div> 
	 					<div class="rTableCell"><input type="password" name="password" id="password"></div> 
	 				</div> 
	 				<div class="rTableRow"> 
	 					<div class="rTableCell"><input type="submit" value="Log in"></div> 
	 				</div> 
  				</div>
  			</form>
  		</div>
	</div>
</body>
</html>