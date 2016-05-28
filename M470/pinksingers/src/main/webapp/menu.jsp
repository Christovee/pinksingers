<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<ul>
	<li><a href="/loadMemberList?action=view">View Member List</a></li>
	<c:if test="${sessionAccess == 'admin'}">
		<li><a href="/loadMemberList?action=edit">Sync Email Groups</a></li>
		<li><a href="/admin/memberEdit.jsp">Add Member</a></li>
		<li><a href="/loadGroups">Email Group</a></li>
		<li><a href="/admin/seasonEdit.jsp">Add Season</a></li>
	</c:if>	
	<li><a href="/logout">Log Out</a></li>
</ul>