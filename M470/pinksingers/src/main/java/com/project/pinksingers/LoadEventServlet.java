package com.project.pinksingers;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;



@SuppressWarnings("serial")
public class LoadEventServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		//Check if parameter is null isn't empty
		if(req.getParameter("eventId") == null)
		{
			resp.sendRedirect("../index.jsp"); 
		}else{
			Long eventId = Long.valueOf(req.getParameter("eventId"));
			doCode(req, resp, eventId);
		}	
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		Long eventId = null;
				
		if(req.getAttribute("eventId") == null)
		{
			eventId = Long.valueOf(req.getParameter("eventId"));
		}else{
			eventId = (Long)req.getAttribute("eventId");
		}
		
		doCode(req, resp, eventId);
				
		
	}
	
	public void doCode(HttpServletRequest req, HttpServletResponse resp, Long eventId) throws IOException, ServletException 
	{
		Event event = ObjectifyService.ofy().load().type(Event.class).id(eventId).now();
		
		req.setAttribute("event", event);
		
		List<Member> memberList = ObjectifyService.ofy().load().type(Member.class).filter("status !=", "Inactive").order("status").order("section").order("subSection").order("firstName").list();
		Collections.sort(memberList);
		req.setAttribute("memberList", memberList);
		
		RequestDispatcher rd = req.getRequestDispatcher("admin/eventEdit.jsp");
		rd.forward(req, resp); 
	}
}