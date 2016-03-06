package com.project.pinksingers;

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

public class LoadMemberListServlet extends HttpServlet {
	@Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		
		List<Member> memberList = ObjectifyService.ofy().load().type(Member.class).order("name").list();
		
		req.setAttribute("memberList", memberList);
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/memberList.jsp");
		rd.forward(req, resp); 
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		  
		  //Redirect Get requests to post request
		  	doPost(req, resp);
		  }
}