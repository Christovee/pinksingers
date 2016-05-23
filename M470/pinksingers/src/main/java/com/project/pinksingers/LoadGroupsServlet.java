package com.project.pinksingers;

import com.google.gson.Gson;

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
		List<Member> altoGroup = ObjectifyService.ofy().load().type(Member.class).filter("section", "ALTO").order("email").list();
		List<Member> bassGroup = ObjectifyService.ofy().load().type(Member.class).filter("section", "BASS").order("email").list();
		List<Member> tenorGroup = ObjectifyService.ofy().load().type(Member.class).filter("section", "TENOR").order("email").list();
		List<Member> sopranoGroup = ObjectifyService.ofy().load().type(Member.class).filter("section", "SOPRANO").order("email").list();
		
		String altoEmails = convertToString(altoGroup);
		String bassEmails = convertToString(bassGroup);
		String tenorEmails = convertToString(tenorGroup);
		String sopranoEmails = convertToString(sopranoGroup);
		
		req.setAttribute("altoGroup", altoGroup);
		req.setAttribute("altoEmails", altoEmails);
		req.setAttribute("bassGroup", bassEmails);
		req.setAttribute("tenorGroup", tenorEmails);
		req.setAttribute("sopranoGroup", sopranoEmails);
		
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin/sendGroupEmail.jsp");
		
		rd.forward(req, resp); 
	}
	
	private String convertToString(List<Member> group)
	{
			ArrayList<String> myArray = new ArrayList<>();
		
			for(Member member: group)
			{
				myArray.add(member.getEmail());
			}
		
			return new Gson().toJson(myArray);
	}
}