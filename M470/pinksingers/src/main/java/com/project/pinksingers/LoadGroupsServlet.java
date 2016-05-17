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

import javax.servlet.http.*;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class LoadGroupsServlet extends HttpServlet {
	@Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		
		  //Redirect Get requests to post request
		  	doGet(req, resp);
		
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		List<Member> altoGroup = ObjectifyService.ofy().load().type(Member.class).filter("Section", "ALTO").order("email").list();
		List<Member> bassGroup = ObjectifyService.ofy().load().type(Member.class).filter("Section", "BASS").order("email").list();
		List<Member> tenorGroup = ObjectifyService.ofy().load().type(Member.class).order("email").list();
		List<Member> sopranoGroup = ObjectifyService.ofy().load().type(Member.class).filter("Section", "SOPRANO").order("email").list();

		
		req.setAttribute("altoGroup", altoGroup);
		req.setAttribute("bassGroup", bassGroup);
		req.setAttribute("tenorGroup", tenorGroup.toString());
		req.setAttribute("sopranoGroup", sopranoGroup);
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin/sendGroupEmail.jsp");
		
		rd.forward(req, resp); 
		  }
}