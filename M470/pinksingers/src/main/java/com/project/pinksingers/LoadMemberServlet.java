package com.project.pinksingers;

import java.io.IOException;

import javax.servlet.http.*;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;

import com.googlecode.objectify.ObjectifyService;


public class LoadMemberServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		//Check if parameter is null isn't empty
		if(req.getParameter("memberId") == null)
		{
			resp.sendRedirect("../index.jsp"); 
		}else{
			Long memberId = Long.valueOf(req.getParameter("memberId"));
		
			Member member = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
		
			req.setAttribute("member", member);
		
			RequestDispatcher rd = getServletContext().getRequestDispatcher("/member.jsp");
			rd.forward(req, resp); 
		}
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		Long memberId = null;
				
		if(req.getAttribute("memberId") == null)
		{
			memberId = Long.valueOf(req.getParameter("memberId"));
		}else{
			memberId = (Long)req.getAttribute("memberId");
		}
				
				
		Member member = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
		
				
		req.setAttribute("member", member);
				
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/member.jsp");
		rd.forward(req, resp); 
	}
}