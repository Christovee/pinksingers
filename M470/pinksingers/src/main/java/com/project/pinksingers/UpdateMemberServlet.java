package com.project.pinksingers;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Blob;

import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.VoidWork;

public class UpdateMemberServlet extends HttpServlet {
	  @Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	
		  final Long memberId = Long.valueOf(req.getParameter("memberId"));
		  final String firstName = req.getParameter("firstName");
		  final String lastName = req.getParameter("lastName");
		  final String section = req.getParameter("section");
		  final String subSection = req.getParameter("subSection");
		  final String adminLevel = req.getParameter("adminLevel");
		  final String email = req.getParameter("email");
		  
		  ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
			    	Member member = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
			    	
			    	member.setFirstName(firstName);
			    	member.setLastName(lastName);
			    	member.setSection(section);
			    	member.setSubSection(subSection);
			    	member.setAdminLevel(adminLevel);
			   		member.setEmail(email);
			    	
			    	ObjectifyService.ofy().save().entity(member);
			    }
			    }); 
		  
		  req.setAttribute("memberId", memberId);
		  req.setAttribute("status", "updated");
		  RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadMember");
		  rd.forward(req, resp); 
	  }
}
