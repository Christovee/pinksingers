package com.project.pinksingers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;
import com.google.gson.Gson;



@SuppressWarnings("serial")
public class LoadSeasonServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		//Check if parameter is null isn't empty
		if(req.getParameter("seasonId") == null)
		{
			resp.sendRedirect("../index.jsp"); 
		}else{
			Long seasonId = Long.valueOf(req.getParameter("seasonId"));
			doCode(req, resp, seasonId);
		}	
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		Long seasonId = null;
				
		if(req.getAttribute("seasonId") == null)
		{
			seasonId = Long.valueOf(req.getParameter("seasonId"));
		}else{
			seasonId = (Long)req.getAttribute("seasonId");
		}
		
		doCode(req, resp, seasonId);
				
		
	}
	
	public void doCode(HttpServletRequest req, HttpServletResponse resp, Long seasonId) throws IOException, ServletException 
	{	
		//Get current season and seasonMembers and set attribute
		Season season = ObjectifyService.ofy().load().type(Season.class).id(seasonId).now();
		req.setAttribute("season", season);
		ArrayList<SeasonMember> seasonMembers = season.getSeasonMembers();
		req.setAttribute("seasonMembers", seasonMembers);
		ArrayList<Rehearsal> rehearsals = season.getRehearsals();
		Collections.sort(rehearsals);
		req.setAttribute("rehearsals", rehearsals);
		
		
		//Get previous season Ids
		ArrayList<Long> prevSeasonIds = Season.getPreviousSeasonIds(seasonId);
		
		//Get last season Member list and set attribute. 
		req.setAttribute("prevSeasonMembers0", getSeasonMembers(prevSeasonIds.get(0)));
		
		//Get season before last Member list and set attribute
		req.setAttribute("prevSeasonMembers1", getSeasonMembers(prevSeasonIds.get(1)));
		
		//Get member list. Sort by section and set attribute. 
		List<Member> memberList = ObjectifyService.ofy().load().type(Member.class).filter("status !=", "Inactive").order("status").order("section").order("subSection").order("firstName").list();
		Collections.sort(memberList);
		req.setAttribute("memberList", memberList);
		
		RequestDispatcher rd = req.getRequestDispatcher("/admin/seasonEdit.jsp");
		rd.forward(req, resp); 
	}
	
	private ArrayList<SeasonMember> getSeasonMembers(Long seasonId)
	{
		ArrayList<SeasonMember> prevSeasonMembers;
		if(!seasonId.equals(0L))
		{	
			Season season = ObjectifyService.ofy().load().type(Season.class).id(seasonId).now();
			prevSeasonMembers = season.getSeasonMembers();
		}else{
			prevSeasonMembers = new ArrayList<>();
		}
		
		return prevSeasonMembers;
	}
	
}