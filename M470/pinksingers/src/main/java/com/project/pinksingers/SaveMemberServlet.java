package com.project.pinksingers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
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
	String status = req.getParameter("status");
	
	member = new Member(firstName, lastName, section, subSection, adminLevel, email, status);
	
	ObjectifyService.ofy().save().entity(member).now();
	
	Long memberId = member.getMemberId();
	
	req.setAttribute("memberId", memberId);
	req.setAttribute("status", "saved");
	RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadMember");
	rd.forward(req, resp); 
	}

}
