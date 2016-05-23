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

      var SCOPES = ['https://www.googleapis.com/auth/admin.directory.group.member.readonly', 'https://www.googleapis.com/auth/admin.directory.group.readonly', ];

      var altoGroup = [];
      var bassGroup = [];
      var tenorGroup = [];
      var sopranoGroup = [];
      
      $(document).ready(function() {
      	altoGroup = ${altoEmails};
      	bassGroup = ${bassGroup};
      	tenorGroup = ${tenorGroup};
      	sopranoGroup = ${sopranoGroup};
      	
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

      /**
       * Print the first 10 users in the domain.
       */
      /*function listUsers() {
        var request = gapi.client.directory.users.list({
          'domain': 'viveash.net',
          'fields': 'users',
          'maxResults': 10,
          'orderBy': 'email'
        });*/
        
        /*function listUsers() {
            var request = gapi.client.directory.members.list({
              'groupKey': 'testgroup1@viveash.net',
              'fields': 'members',
              'maxResults': 10,
            });*/
            
		function listUsers() 
		{
        	listMembers("output", "altos@viveash.net");
		
			/*var request = gapi.client.directory.groups.list({
        	'domain': 'viveash.net',
            'fields': 'groups',
            'maxResults': 10,
        	});  
			
			request.execute(function(resp) {
          		var members = resp.groups;

          		if (members && members.length > 0) 
          		{
            		for (i = 0; i < members.length; i++) 
            		{
              			var member = members[i];
              			appendPre("output", member.name, member.email);
            		}
          		} else {
            			//appendPre('No users found.');
          		}
        	});*/
      	}
            
        function listMembers(divId, groupEmail) 
    	{
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
                  		console.log(domainGroup);
                  		//appendPre(divId, member.name, member.email);
                  			
                	}
         
              	}
            checkMembers(domainGroup);  	
            });
    			
 		}
            
       function checkMembers(domainGroup)
       {
       		console.log(domainGroup);
       		console.log(altoGroup);
			for( var i =0; i < altoGroup.length; i++ )
    		{
				if(domainGroup.indexOf(altoGroup[i]) != -1)
				{
					$('[name="'+altoGroup[i]+'"]').html("True");
				}else{
					$('[name="'+altoGroup[i]+'"]').html("False");
				}
				
    		}	   
       }
    	   

      /**
       * Append a pre element to the body containing the given message
       * as its text node.
       *
       * @param {string} message Text to be placed in pre element.
       */
      function appendPre(divId, name, email) {  
    	   
       	if(divId == "output")
       	{
    		$("#"+divId).append("<div id='"+name+"'><a href='#' onclick='listMembers(&quot;"+name+"&quot;,&quot;"+email+"&quot); return false'>"+name+" ("+email+")</a></div>");
       	}else{
       		$("#"+divId).append("<p>"+email+"</p>");
       	}  
      }

    </script>
    <script src="https://apis.google.com/js/client.js?onload=checkAuth">
    </script>
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
    			<th colspan="3">Altos</th>
    		<tr>
    		<tr>
    			<th>Name</th>
    			<th>Email</th>
    			<th>Mailing Group</th>
    		</tr>
    		<c:forEach var="item" items="${altoGroup}">
    			<tr>
    				<td>${item.firstName}&nbsp;${item.lastName}</td>
    				<td>${item.email}</td>
    				<td name='${item.email}'></td>
    			</tr>
    		</c:forEach>	
    	</table>
    </div>
  </div>
</div>
</body>
</html>
