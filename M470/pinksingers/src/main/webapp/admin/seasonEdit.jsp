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
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.js"></script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript" src="../scripts/modernizr.js"></script>
<script>
$(document).ready(function() {
	<c:forEach var="item" items="${memberList}">
		$("#section"+${item.memberId}).val('${item.section}');
		$("#subSection"+${item.memberId}).val('${item.subSection}');
		$("#status"+${item.memberId}).val('${item.status}');
	</c:forEach>
	
	if(${season.currentSeason == true})
	{
		$("#currentSeason").prop('checked', true);
		$("#isCurrentSeason").val("true");
	}else{
		$("#isCurrentSeason").val("false");
	}
	
	<c:forEach var="item" items="${seasonMembers}">
		$("#"+${item.member.memberId}).css('background', 'green');
		$("#section"+${item.member.memberId}).val('${item.seasonSection}');
		$("#subSection"+${item.member.memberId}).val('${item.seasonSubSection}');
		$("#status"+${item.member.memberId}).val('${item.seasonStatus}');
	</c:forEach>
	
	<c:forEach var="member" items="${prevSeasonMembers0}">
		var prevString = "";
		if("${member.seasonStatus}" == "Active")
		{
			switch ("${member.seasonSection}") {
            	case "Alto":  
            		prevString += "A";
                     break;
            	case "Bass":
            		prevString += "B";
            		break;
            	case "Soprano":
            		prevString += "S";
            		break;
            	case "Tenor":
            		prevString += "T";
			}
			prevString += String(${member.seasonSubSection});
		}else{
			switch ("${member.seasonStatus}") {
				case "Resting":
					prevString += "Re";
					break;
				case "Parental Leave":
					prevString += "PL";
					break;
				case "Dropped Out":
					prevString += "DO";
					break;
				case "Dropped Out (EC)":
					prevString += "DE";	
			}
		}
		$("#prevSeasons"+${member.member.memberId}).html($("#prevSeasons"+${member.member.memberId}).html()+" "+prevString);
	</c:forEach>
	
	<c:forEach var="member" items="${prevSeasonMembers1}">
	var prev1String = "";
	if("${member.seasonStatus}" == "Active")
	{
		switch ("${member.seasonSection}") {
        	case "Alto":  
        		prev1String += "A";
                 break;
        	case "Bass":
        		prev1String += "B";
        		break;
        	case "Soprano":
        		prev1String += "S";
        		break;
        	case "Tenor":
        		prev1String += "T";
		}
		prev1String += String(${member.seasonSubSection});
	}else{
		switch ("${member.seasonStatus}") {
			case "Resting":
				prev1String += "Re";
				break;
			case "Parental Leave":
				prev1String += "PL";
				break;
			case "Dropped Out":
				prev1String += "DO";
				break;
			case "Dropped Out (EC)":
				prev1String += "DE";	
		}
	}
	$("#prevSeasons"+${member.member.memberId}).html($("#prevSeasons"+${member.member.memberId}).html()+" "+prev1String);
	</c:forEach>
	
	//Register handler to update the hidden field on seasonMembers form
	$('#currentSeason').change(function() {
		   if($(this).is(":checked")) {
			   $("#isCurrentSeason").val("true");
		      return;
		   }
		   $("#isCurrentSeason").val("false");
	});
	
	
	//Hide the seasonMembers table when the page loads. 
	$("#seasonMembers").hide();
	$("#rehearsals").hide();
	
	//Check for HTML5 input=date compatibility. If not, use javascript validation
	if(!Modernizr.inputtypes.date)
	{
		$('#seasonForm').validate({
			rules: {
				seasonName: "required",
			    seasonStart: {required: true, dateISO: true},
				seasonEnd: {required: true, dateISO: true}
			  },
			messages: {
				seasonStart: "Must be in format yyyy-mm-dd",
				seasonEnd: "Must be in format yyyy-mm-dd"
			}
		});	
	}
	
	
});

function toggleSeasonMembers()
{
	$("#seasonMembers").toggle();
}

function toggleRehearsals()
{
	$("#rehearsals").toggle();
}

</script>
</head>
<body>
	<div class="header"></div>
<div class="row">
  <div class="col-3 menu">
  <ul>
	<jsp:include page="../menu.jsp" />
  </ul>
  </div>
  <div class="col-9">
  <c:choose>
		<c:when test="${empty season.id}">
			<c:set var="formAction" value="saveSeason"/>
		</c:when>
		<c:otherwise>
			<c:set var="formAction" value="updateSeason"/>
		</c:otherwise>
	</c:choose>
	<c:if test="${status == 'updated'}"><div class="error">Changes have been saved</div></c:if>
	<c:if test="${status == 'saved'}"><div class="error">Season has been added</div></c:if>
	<div class="title">Season Details</div>
	<form action="/${formAction}" method="post" id="seasonForm" name="seasonForm" class="rTable">
	<input type="hidden" name="seasonId" value="${season.id}">
		<div class="rTableRow"> 
			<div class="rTableCell"><label>Season Name</label></div>
			<div class="rTableCell"><input type="text" id="seasonName" name="seasonName" value="${season.name}" required></div>
		</div>
		<div class="rTableRow">
			<div class="rTableCell"><label>Concert Title</label></div>
			<div class="rTableCell"><input type="text" id="concertTitle" name="concertTitle" value="${season.concertTitle}"></div>
		</div>
		<div class="rTableRow">
			<div class="rTableCell"><label>Start Date</label></div>
			<div class="rTableCell"><input type="date" id="seasonStart" name="seasonStart"  value="${season.start}" required></div>
		</div>
		<div class="rTableRow">
			<div class="rTableCell"><label>End Date</label></div>
			<div class="rTableCell"><input type="date" id="seasonEnd" name="seasonEnd" value="${season.end}" required></div>
		</div>
		<div class="rTableRow">
			<div class="rTableCell"><label>Current Season?</label></div>
			<div class="rTableCell"><input type="checkbox" id="currentSeason" name="currentSeason" value="true"></div>
		</div>
		<div class="rTableRow">
			<div class="rTableCell">&nbsp;</div>
			<c:choose>
				<c:when test="${empty season.id}">
					<div class="rTableCell"><input type="submit" value="Add season"></div>
				</c:when>
				<c:otherwise>
					<div class="rTableCell"><input type="submit" value="Update season"></div>
				</c:otherwise>
			</c:choose>	
		</div>
	</form>
	<c:if test="${not empty season.id}">
		<button type="button" onclick="toggleSeasonMembers()">View/Hide Members</button>
		<button type="button" onclick="toggleRehearsals()">View/Hide Rehearsals</button>
		<div id="seasonMembers">
			<div class="title">Season Member Details</div>
			<form action="/updateSeasonMembers" method="post" id="seasonMemberForm" name="seasonMemberForm" class="rTable">
				<input type="hidden" name="seasonId" value="${season.id}">
				<input type="hidden" name="isCurrentSeason" id="isCurrentSeason">
				
					<div class="rTableRow">
						<div class="dotCell rTableHead"></div>
						<div class="rTableHead">Name</div>
						<div class="rTableHead">Section</div>
						<div class="rTableHead">Status</div>
						<div class="rTableHead">Prev</div>
					</div>
					<c:forEach var="item" items="${memberList}" varStatus="theCount">
					<input type=hidden name="memberId${theCount.count}" value="${item.memberId}">
  						<div class="rTableRow">
  							<div class="dotCell rTableCell"><div id="${item.memberId}" class="dot" style="background: red"></div></div>
							<div class="rTableCell">${item.firstName} ${item.lastName}</div>
							<div class="rTableCell">
								<select name="section${theCount.count}" id="section${item.memberId}">
									<option value="Soprano">Soprano</option>
									<option value="Alto">Alto</option>
									<option value="Tenor">Tenor</option>
									<option value="Bass">Bass</option>
								</select>
								<select name="subSection${theCount.count}" id="subSection${item.memberId}">
									<option value=1>1</option>
									<option value=2>2</option>
								</select>
							</div>
							<div class="rTableCell">
								<select name="status${theCount.count}" id="status${item.memberId}">
									<option value="Active">Active</option>
									<option value="Resting">Resting</option>
									<option value="Parental Leave">Parental leave</option>
									<option value="Dropped Out (EC)">Dropped Out (EC)</option>
									<option value="Dropped Out">Dropped Out</option>
									<option value="Inactive">Inactive</option>
								</select>
							</div>
							<div class="rTableCell" id="prevSeasons${item.memberId}"></div>
						</div>
					<c:set var="finalCount" value="${theCount.count}" />
					</c:forEach>
					<input type="hidden" name="finalCount" value="${finalCount}">
					<div class="rTableRow">
						<div class="dotCell rTableCell"></div>
						<div class="rTableCell"><input type="submit" value="submit"></div>
					</div>
				</form>
		</div>	
		<div id="rehearsals">
			<div class="title">Rehearsals</div>
		 	<div class="rTable">
				<div class="rTableRow">
					<div class="rTableHead">Name</div>
					<div class="rTableHead">Date</div>
				</div>
				<c:forEach var="rehearsal" items="${rehearsals}">
					<div class="rTableRow">
						<div class="rTableCell"><a href="loadRehearsal?rehearsalId=${rehearsal.id}&seasonId=${season.id}">${rehearsal.name}</a></div>
						<div class="rTableCell">
							<a href="loadRehearsal?rehearsalId=${rehearsal.id}&seasonId=${season.id}">
								<fmt:formatDate type="date" value="${rehearsal.javaStart}" />
							</a>
						</div>
					</div>
				</c:forEach>
				<div class="rTableRow">
					<div class="rTableCell"><a href="loadRehearsal?seasonId=${season.id}">Add Rehearsal</a></div>
					<div></div>
				</div>
			</div>
		</div>
	</c:if>
  </div>
</div>
</body>
</html>