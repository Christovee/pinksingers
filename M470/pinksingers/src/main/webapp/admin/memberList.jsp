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
<meta name=viewport content="width=device-width, initial-scale=1">
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
		listMembers("sopranos@viveash.net", sopranoEmails, "Soprano", "S");
    	listMembers("altos@viveash.net", altoEmails, "Alto", "S");	
    	listMembers("tenors@viveash.net", tenorEmails, "Tenor", "S");
    	listMembers("basses@viveash.net", bassEmails, "Bass", "S");
    	listMembers("fullchoir@viveash.net", allEmails, "FullChoir", "C");
      	}
            
	function listMembers(groupEmail, serverGroup, section, letter) {
    	
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
        	checkMembers(domainGroup, groupEmail, serverGroup, section, letter);  	
        });
	}
		
	function addUser(memberEmail, groupEmail, section, letter) {
		
		var member = {"email": memberEmail, "role":"MEMBER"};
		
	    var request = gapi.client.directory.members.insert({
			'groupKey': groupEmail,
			'resource': member,
	    });
	    			
		request.execute(function(resp) {

	        var html = "<button class='member'>"+letter+"</button>"
			$('.'+section+'[id="'+memberEmail+'"]').html(html); 	
	    }); 			
 	}
	
	function deleteUser(section, memberEmail, groupEmail, letter)
	{
		var request = gapi.client.directory.members.delete({
			'groupKey': groupEmail,
			'memberKey': memberEmail,
	    });
	    			
		request.execute(function(resp) {

	        var html = "<button class='removed'>"+letter+"</button>"
			$('[id="'+section+memberEmail+'"]').html(html); 	
	    }); 	
		
	}
            
	function checkMembers(domainGroup, groupEmail, serverGroup, section, letter)
    {
		for( var i =0; i < serverGroup.length; i++ )
    	{
			if(domainGroup.indexOf(serverGroup[i]) != -1)
			{
				var html = "<button class='member'>"+letter+"</button>";
				$('.'+section+'[id="'+serverGroup[i]+'"]').html(html);
				var index = domainGroup.indexOf(serverGroup[i]);
				domainGroup.splice(index, 1);
			}
			else{
				var html = "<button class='add' onclick='addUser(&quot;"+serverGroup[i]+"&quot;,&quot;"+groupEmail+"&quot;,&quot;"+section+"&quot;,&quot;"+letter+"&quot;)'>"+letter+"</button>";
				$('.'+section+'[id="'+serverGroup[i]+'"]').html(html);
			}
		}	
		outputExtraMembers(section, domainGroup, groupEmail, letter);
	}
	
	function outputExtraMembers(section, domainGroup, groupEmail, letter)
	{
		if(domainGroup.length > 0)
		{
			var html = $("#groups").html() + "<div class='rTableRow'><div class='rTableCell'>Group:"+groupEmail+"</div></div>";
			for(var i = 0; i < domainGroup.length; i++)
			{
				html = html + "<div class='rTableRow'><div class='rTableCell'>"+domainGroup[i]+"</div>";
				html = html + "<div class='rTableCell' id='"+section+domainGroup[i]+"'>";
				html = html + "<button class='add' onclick='deleteUser(&quot;"+section+"&quot;,&quot;"+domainGroup[i]+"&quot;,&quot;"+groupEmail+"&quot;,&quot;"+letter+"&quot;)'>"+letter+"</button></div></div>";
			}
			$("#groups").html(html);
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
    	<span>To use this feature you must authorise with a Pink Singers Admin Account</span>
      	<!--Button for the user to click to initiate auth sequence -->
		<button id="authorize-button" onclick="handleAuthClick(event)">
        	Authorise
      	</button>
    </div>
    <div id="output" style="display: none">
  		<div class="rTable"> 
 			<div class="rTableRow">
  				<div class="rTableHead">Name</div>
  				<div class="rTableHead">Section</div>
  				<div class="rTableHead">Groups</div>
 			</div>
  			<c:forEach var="item" items="${memberList}">
  				<div class="rTableRow">
    				<div class="rTableCell">${item.firstName}&nbsp;${item.lastName}</div>
    				<div class="rTableCell">${item.section}&nbsp;${item.subSection}</div>
    				<div class="rTableCell">
    					<span class="FullChoir buttons"  id='${item.email}'></span>
    					<span class="${item.section} buttons" id='${item.email}'></span>
    				</div>
				</div>
			</c:forEach>
		</div>
		<div class="rTable" id="groups">
  		</div>
  	</div>
  </div>
</div>
</body>
</html>