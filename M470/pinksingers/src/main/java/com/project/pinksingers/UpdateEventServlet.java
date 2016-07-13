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
public class UpdateEventServlet extends HttpServlet {
	  @Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	
		  	final Long eventId = Long.valueOf(req.getParameter("eventId"));
		  	final String eventName = req.getParameter("eventName");
			final String eventStart = req.getParameter("eventStart");
			final String eventEnd = req.getParameter("eventEnd");
			final String location = req.getParameter("location");
			
					  
		  ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
			    	Event event = ObjectifyService.ofy().load().type(Event.class).id(eventId).now();
			    	
			    	event.setName(eventName);
			    	event.setStart(eventStart);
			    	event.setEnd(eventEnd);
			    	event.setLocation(location);
			    				    	
			    	ObjectifyService.ofy().save().entity(event);
			    }
			    }); 
		  
		  req.setAttribute("status", "updated");
		  RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadEvent?eventId="+eventId);
		  rd.forward(req, resp); 
	  }
}
