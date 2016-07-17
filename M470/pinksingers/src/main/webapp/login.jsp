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
  <table>
  <c:if test="${status == 'userName'}">
  <tr>
  	<td colspan=2>Email is not recognised.</td>
  </tr>
  </c:if>
  <c:if test="${status == 'password'}">
  <tr>
  	<td colspan=2>Password is incorrect.</td>
  </tr>
  </c:if>
  <tr>
  	<td><label>Email</label></td>
  	<td><label><input type="email" name="email" id="email"></label>
  </tr>
  <tr>
  	<td><label>Password</label></td>
  	<td><label><input type="password" name="password" id="password"></label>
  </tr>
  <tr>
	<td>&nbsp;</td>
	<td><input type="submit"></td>
  </tr>
  </table>
  </form>
  </div>
</div>
</body>
</html>