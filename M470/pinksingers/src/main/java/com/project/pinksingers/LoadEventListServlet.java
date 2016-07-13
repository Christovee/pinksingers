package com.project.pinksingers;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class LoadEventListServlet extends HttpServlet {
	@Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		
		//Retreive list of seasons in ascending order by start date. 
		List<Event> eventList = ObjectifyService.ofy().load().type(Event.class).order("-start").list();
	
		req.setAttribute("eventList", eventList);
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin/eventList.jsp");
		
		rd.forward(req, resp); 
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		  
		  //Redirect Get requests to post request
		  	doPost(req, resp);
	}
}