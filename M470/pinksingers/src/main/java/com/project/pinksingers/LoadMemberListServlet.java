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

import com.google.gson.Gson;
import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class LoadMemberListServlet extends HttpServlet {
	@Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		
		List<Member> memberList = ObjectifyService.ofy().load().type(Member.class).order("section").order("subSection").order("firstName").list();
		
		Collections.sort(memberList);
		
		String allEmails = convertToString(memberList);
		
		req.setAttribute("allEmails", allEmails);
		req.setAttribute("memberList", memberList);
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/memberList.jsp");
		
		//if Edit Member List select go to admin section
		if(req.getParameter("action").equals("edit"))
		{
			List<Member> altoGroup = ObjectifyService.ofy().load().type(Member.class).filter("section", "ALTO").order("email").list();
			List<Member> bassGroup = ObjectifyService.ofy().load().type(Member.class).filter("section", "BASS").order("email").list();
			List<Member> tenorGroup = ObjectifyService.ofy().load().type(Member.class).filter("section", "TENOR").order("email").list();
			List<Member> sopranoGroup = ObjectifyService.ofy().load().type(Member.class).filter("section", "SOPRANO").order("email").list();
			
			String altoEmails = convertToString(altoGroup);
			String bassEmails = convertToString(bassGroup);
			String tenorEmails = convertToString(tenorGroup);
			String sopranoEmails = convertToString(sopranoGroup);
			
			req.setAttribute("altoEmails", altoEmails);
			req.setAttribute("bassEmails", bassEmails);
			req.setAttribute("tenorEmails", tenorEmails);
			req.setAttribute("sopranoEmails", sopranoEmails);
			
			rd = getServletContext().getRequestDispatcher("/admin/memberList.jsp");
		}
		
		rd.forward(req, resp); 
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		  
		  //Redirect Get requests to post request
		  	doPost(req, resp);
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