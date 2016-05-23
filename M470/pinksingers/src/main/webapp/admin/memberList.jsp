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
<script type="text/javascript">
      
	var CLIENT_ID = '582070922829-cln9q9bes7uq0ogvb9qimgcstpg5ce3j.apps.googleusercontent.com';

	var SCOPES = ['https://www.googleapis.com/auth/admin.directory.group.member', 'https://www.googleapis.com/auth/admin.directory.group', ];

	var altoEmails = [];
    var bassEmails = [];
    var tenorEmails = [];
    var sopranoEmails = [];
    var allEmails = [];
    
      
	$(document).ready(function() {
    	altoEmails = ${altoEmails};
      	bassEmails = ${bassEmails};
      	tenorEmails = ${tenorEmails};
      	sopranoEmails = ${sopranoEmails};
      	allEmails = ${allEmails};
      	
      });
      
      /**
       * Check if current user has authorized this application.
       */
	function checkAuth() {
        gapi.auth.authorize(
          {
            'client_id': CLIENT_ID,
            'scope': SCOPES.join(' '),
            'immediate': true
          }, handleAuthResult);
      }

	/**
	 * Handle response from authorization server.
     *
     * @param {Object} authResult Authorization result.
     */
	function handleAuthResult(authResult) {
    	if (authResult && !authResult.error) {
		 // Hide auth UI, then load client library.
          $("#authorize-div").hide();
          $("#output").show();
          loadDirectoryApi();
        } else {
          // Show auth UI, allowing the user to initiate authorization by
          // clicking authorize button.
        	$("#authorize-div").show();
            $("#output").hide();
        }
	}

	/**
     * Initiate auth flow in response to user clicking authorize button.
     *
     * @param {Event} event Button click event.
     */
	function handleAuthClick(event) {
		gapi.auth.authorize(
		{client_id: CLIENT_ID, scope: SCOPES, immediate: false},
			handleAuthResult);
        return false;
	}

	/**
	 * Load Directory API client library. List users once client library
	 * is loaded.
	 */
	function loadDirectoryApi() {
        gapi.client.load('admin', 'directory_v1', listUsers);
      }

     
	function listUsers() {
    	listMembers("altos@viveash.net", altoEmails, "Alto");	
    	listMembers("tenors@viveash.net", tenorEmails, "Tenor");
    	listMembers("fullchoir@viveash.net", allEmails, "FullChoir");
      	}
            
	function listMembers(groupEmail, serverGroup, section) {
    	
		var domainGroup = [];
		
		var request = gapi.client.directory.members.list({
			'groupKey': groupEmail,
			'fields': 'members',
			'maxResults': 10,
		});
    	
		
		request.execute(function(resp) {
        	var members = resp.members;

			if (members && members.length > 0) 
        	{
        		for (var i = 0; i < members.length; i++) 
            	{
            		var memberEmail = members[i].email;
                	domainGroup.push(memberEmail);
            	}
         	}
        	checkMembers(domainGroup, groupEmail, serverGroup, section);  	
        });
	}
		
	function addUser(memberEmail, groupEmail, section) {
		
		var member = {"email": memberEmail, "role":"MEMBER"};
		
	    var request = gapi.client.directory.members.insert({
			'groupKey': groupEmail,
			'resource': member,
	    });
	    			
		request.execute(function(resp) {

	        var html = "<button class='member'>Member</button>"
			$('.'+section+'[name="'+memberEmail+'"]').html(html); 	
	    }); 			
 	}
            
	function checkMembers(domainGroup, groupEmail, serverGroup, section)
    {
		for( var i =0; i < serverGroup.length; i++ )
    	{
			if(domainGroup.indexOf(serverGroup[i]) != -1)
			{
				var html = "<button class='member'>Member</button>";
				$('.'+section+'[name="'+serverGroup[i]+'"]').html(html);
			}
			else{
				var html = "<button class='add' onclick='addUser(&quot;"+serverGroup[i]+"&quot;,&quot;"+groupEmail+"&quot;,&quot;"+section+"&quot;)'>Add</button>";
				$('.'+section+'[name="'+serverGroup[i]+'"]').html(html);
			}
		}	   
	}
    	   
    </script>
    <script src="https://apis.google.com/js/client.js?onload=checkAuth"></script>
</head>
<body>
<div class="header"></div>
<div class="row">
  <div class="col-3 menu">
  	<jsp:include page="../menu.jsp" />
  </div>
  <div class="col-9">
  	<div id="authorize-div" style="display: none">
    	<span>Authorize access to Directory API</span>
      	<!--Button for the user to click to initiate auth sequence -->
		<button id="authorize-button" onclick="handleAuthClick(event)">
        	Authorize
      	</button>
    </div>
    <div id="output" style="display: none">
  		<table>
  		<tr>
  			<th colspan=2>Member Info</th>
  			<th colspan=2>Email Groups</th>
 		</tr>
 		<tr>
  			<th>Name</th>
  			<th>Section</th>
  			<th>Choir</th>
  			<th>Section</th>
 		</tr>
  		<c:forEach var="item" items="${memberList}">
  			<tr>
    			<td>${item.firstName}&nbsp;${item.lastName}</td>
    			<td>${item.section}&nbsp;${item.subSection}</td>
    			<td class="FullChoir" name='${item.email}'></td>
    			<td class="${item.section}" name='${item.email}'></td>
			</tr>
		</c:forEach>
  		</table>
  	</div>
  </div>
</div>
</body>
</html>