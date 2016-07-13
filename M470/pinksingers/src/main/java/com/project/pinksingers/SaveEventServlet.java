package com.project.pinksingers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class SaveEventServlet extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

		//Get parameters from form. 
		String eventName = req.getParameter("eventName");
		String eventStart = req.getParameter("eventStart");
		String eventEnd = req.getParameter("eventEnd");
		String location = req.getParameter("location");
		
		final Event event = new Event(eventName, eventStart, eventEnd, location);
	
		ObjectifyService.ofy().save().entity(event).now();
		
		Long eventId = event.getId();
		
		req.setAttribute("eventId", eventId);
		req.setAttribute("status", "saved");
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadEvent?eventId="+eventId);
		rd.forward(req, resp); 
	}

}
