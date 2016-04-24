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
<script type="text/javascript">
      // Your Client ID can be retrieved from your project in the Google
      // Developer Console, https://console.developers.google.com
      var CLIENT_ID = '582070922829-cln9q9bes7uq0ogvb9qimgcstpg5ce3j.apps.googleusercontent.com';

      var SCOPES = ['https://www.googleapis.com/auth/admin.directory.group.member.readonly', 'https://www.googleapis.com/auth/admin.directory.group.readonly'];

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
        var authorizeDiv = document.getElementById('authorize-div');
        if (authResult && !authResult.error) {
          // Hide auth UI, then load client library.
          authorizeDiv.style.display = 'none';
          loadDirectoryApi();
        } else {
          // Show auth UI, allowing the user to initiate authorization by
          // clicking authorize button.
          authorizeDiv.style.display = 'inline';
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
          //'domain': 'viveash.net',
          'domain': 'pinksingers.co.uk',
          'fields': 'users',
          'maxResults': 10,
          'orderBy': 'email'
        });*/
        
        function listUsers() {
            var request = gapi.client.directory.members.list({
              'groupKey': 'tenors@pinksingers.co.uk',
              'fields': 'members',
              'maxResults': 10,
            });

        request.execute(function(resp) {
          var members = resp.members;
          appendPre('Members:');

          if (members && members.length > 0) {
            for (i = 0; i < members.length; i++) {
              var member = members[i];
              appendPre('-' + member.email);
            }
          } else {
            appendPre('No users found.');
          }
        });
      }

      /**
       * Append a pre element to the body containing the given message
       * as its text node.
       *
       * @param {string} message Text to be placed in pre element.
       */
      function appendPre(message) {
        var pre = document.getElementById('output');
        var textContent = document.createTextNode(message + '\n');
        pre.appendChild(textContent);
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
    <pre id="output"></pre>
  
  </div>
</div>
</body>
</html>