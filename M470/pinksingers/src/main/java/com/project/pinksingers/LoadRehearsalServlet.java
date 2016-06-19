package com.project.pinksingers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;



@SuppressWarnings("serial")
public class LoadRehearsalServlet extends HttpServlet {
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
		
		if(req.getParameter("rehearsalId") != null)
		{
			Long rehearsalId = Long.valueOf(req.getParameter("rehearsalId"));
			Rehearsal rehearsal = ObjectifyService.ofy().load().type(Rehearsal.class).id(rehearsalId).now();
			req.setAttribute("rehearsal", rehearsal);
		}
		
		String url = "";
		if(Boolean.valueOf(req.getParameter("register")))
		{
			url = "/admin/takeRegister.jsp";
		}else{
			url = "/admin/rehearsalEdit.jsp";
		}
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp); 
	}
	
	
}