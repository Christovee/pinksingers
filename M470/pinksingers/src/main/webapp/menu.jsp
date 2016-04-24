<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<ul>
	<li><a href="/loadMemberList">View Member List</a></li>
	<c:if test="${sessionAccess == 'admin'}">
		<li><a href="/admin/memberEdit.jsp">Add Member</a></li>
		<li><a href="/admin/sendGroupEmail.jsp">Email Group</a></li>
	</c:if>	
	<li><a href="/logout">Log Out</a></li>
</ul>