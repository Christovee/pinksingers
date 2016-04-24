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
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import com.googlecode.objectify.ObjectifyService;

public class SaveMemberServlet extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	Member member;
	
	String firstName = req.getParameter("firstName");
	String lastName = req.getParameter("lastName");
	Section section = Section.convertString(req.getParameter("section"));
	String subSection = req.getParameter("subSection");
	String adminLevel = req.getParameter("adminLevel");
	String email = req.getParameter("email");
	
	member = new Member(firstName, lastName, section, subSection, adminLevel, email);
	
	ObjectifyService.ofy().save().entity(member).now();
	
	Long memberId = member.getMemberId();
	
	req.setAttribute("memberId", memberId);
	req.setAttribute("status", "saved");
	RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadMember");
	rd.forward(req, resp); 
	}

}
