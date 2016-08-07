package com.project.pinksingers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.VoidWork;

@SuppressWarnings("serial")
public class UpdateMemberServlet extends HttpServlet {
	  @Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	
		  final Long memberId = Long.valueOf(req.getParameter("memberId"));
		  
		  if(req.getParameter("view") != null || req.getParameter("view").equals("profile"))
		  {
			  final String funFact = req.getParameter("funFact");
			  final String password = req.getParameter("password");
			  
			  ObjectifyService.ofy().transact(new VoidWork() {
				    public void vrun() {
				    	Member member = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
				    	
				    	member.setFunFact(funFact);
				    	if(password.length()>0)
				    	{
				    		member.setPassword(password);
				    	}
				    	ObjectifyService.ofy().save().entity(member);
				    }
				    }); 
		    
		  }else{
			  final String firstName = req.getParameter("firstName");
			  final String lastName = req.getParameter("lastName");
			  final Section section = Section.convertString(req.getParameter("section"));
			  final String subSection = req.getParameter("subSection");
			  final String adminLevel = req.getParameter("adminLevel");
			  final String email = req.getParameter("email");
			  final String status = req.getParameter("status");
		  
			  ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
			    	Member member = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
			    	
			    	member.setFirstName(firstName);
			    	member.setLastName(lastName);
			    	member.setSection(section);
			    	member.setSubSection(subSection);
			    	member.setAdminLevel(adminLevel);
			   		member.setEmail(email);
			   		member.setStatus(status);
			    	
			    	ObjectifyService.ofy().save().entity(member);
			    }
			    }); 
		  }
		  
		  req.setAttribute("memberId", memberId);
		  req.setAttribute("status", "updated");
		  RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadMember");
		  rd.forward(req, resp); 
	  }
}
