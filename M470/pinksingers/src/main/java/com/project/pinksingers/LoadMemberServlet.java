package com.project.pinksingers;

import com.google.appengine.api.datastore.Blob;
import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;
import java.util.*;
import java.text.SimpleDateFormat;

import javax.servlet.http.*;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

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