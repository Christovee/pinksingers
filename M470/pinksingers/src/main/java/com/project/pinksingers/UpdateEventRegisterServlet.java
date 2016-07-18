package com.project.pinksingers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.VoidWork;

@SuppressWarnings("serial")
public class UpdateEventRegisterServlet extends HttpServlet {
	  @Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	
		  int count = Integer.parseInt(req.getParameter("finalCount"));
		  
		  ArrayList<Register> register = new ArrayList<>();
		  Long memberId;
		  Member member;
		  String status;
		  
		  for(int i = 1; i <= count; i++)
		  {
			  memberId = Long.valueOf(req.getParameter("memberId"+i));
			  member = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
			  status = req.getParameter("status"+i);
			  register.add(new Register(member, status));
		  }
		  
		  final ArrayList<Register> finalRegister = register;
		  
		  final Long eventId = Long.valueOf(req.getParameter("eventId"));
		  
		  ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
			    	Event event = ObjectifyService.ofy().load().type(Event.class).id(eventId).now();
			    	
			    	event.setRegister(finalRegister);
			    	
			    	ObjectifyService.ofy().save().entity(event);
			    }
		  }); 
		  
		  RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadEvent?eventId="+eventId);
		  rd.forward(req, resp); 
	  }
}

