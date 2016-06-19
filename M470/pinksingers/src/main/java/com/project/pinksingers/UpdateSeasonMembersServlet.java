package com.project.pinksingers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.VoidWork;

@SuppressWarnings("serial")
public class UpdateSeasonMembersServlet extends HttpServlet {
	  @Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	
		  int count = Integer.parseInt(req.getParameter("finalCount"));
		  
		  ArrayList<SeasonMember> seasonMembers = new ArrayList<>();
		  Long memberId;
		  Member member;
		  String status;
		  String section;
		  String subSection;
		  boolean currentSeason = Boolean.valueOf(req.getParameter("isCurrentSeason"));
		  
		  
		  for(int i = 1; i <= count; i++)
		  {
			  memberId = Long.valueOf(req.getParameter("memberId"+i));
			  member = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
			  status = req.getParameter("status"+i);
			  section = req.getParameter("section"+i);
			  subSection = req.getParameter("subSection"+i);
			  seasonMembers.add(new SeasonMember(member, status, section, subSection));
			  if(currentSeason)
			  {
				  updateMember(memberId, status, section, subSection);
			  }
		  }
		  
		  final ArrayList<SeasonMember> finalSeasonMembers = seasonMembers;
		  
		  final Long seasonId = Long.valueOf(req.getParameter("seasonId"));
		  
		  ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
			    	Season season = ObjectifyService.ofy().load().type(Season.class).id(seasonId).now();
			    	
			    	season.setSeasonMembers(finalSeasonMembers);
			    	
			    	ObjectifyService.ofy().save().entity(season);
			    }
		  }); 
		  
		  
		  
		  req.setAttribute("seasonId", seasonId);
		  req.setAttribute("status", "updated");
		  RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadSeason");
		  rd.forward(req, resp); 
	  }
	  
	  public void updateMember(Long memberId, String status, String section, String subSection)
	  {
		  final Long finalMemberId = memberId;
		  final String finalStatus = status;
		  final Section finalSection = Section.convertString(section);
		  final String  finalSubSection = subSection;
		  
		  ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
			    	Member member = ObjectifyService.ofy().load().type(Member.class).id(finalMemberId).now();
			    	
			    	member.setStatus(finalStatus);
			    	member.setSection(finalSection);
			    	member.setSubSection(finalSubSection);
			    	
			    	ObjectifyService.ofy().save().entity(member);
			    }
		  }); 
		  
	  }
}

