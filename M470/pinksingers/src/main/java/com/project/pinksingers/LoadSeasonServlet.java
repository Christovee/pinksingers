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
		Season season = ObjectifyService.ofy().load().type(Season.class).id(seasonId).now();
		
		req.setAttribute("season", season);
		
		ArrayList<SeasonMember> seasonMembers = season.getSeasonMembers();
		
		req.setAttribute("seasonMembers", seasonMembers);
		
		List<Member> memberList = ObjectifyService.ofy().load().type(Member.class).filter("status !=", "Inactive").order("status").order("section").order("subSection").order("firstName").list();
		
		Collections.sort(memberList);
		
		req.setAttribute("memberList", memberList);
		
		RequestDispatcher rd = req.getRequestDispatcher("/admin/seasonEdit.jsp");
		rd.forward(req, resp); 
	}
	
}