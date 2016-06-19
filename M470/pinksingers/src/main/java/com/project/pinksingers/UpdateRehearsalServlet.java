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
public class UpdateRehearsalServlet extends HttpServlet {
	  @Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	
		  	final Long rehearsalId = Long.valueOf(req.getParameter("rehearsalId"));
		  	Long seasonId = Long.valueOf(req.getParameter("seasonId"));
		  	final String rehearsalName = req.getParameter("rehearsalName");
			final String rehearsalStart = req.getParameter("rehearsalStart");
			final String rehearsalEnd = req.getParameter("rehearsalEnd");
			final String location = req.getParameter("location");
			final boolean attendanceRequired = Boolean.valueOf(req.getParameter("attendanceRequired"));	
		  
		  ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
			    	Rehearsal rehearsal = ObjectifyService.ofy().load().type(Rehearsal.class).id(rehearsalId).now();
			    	
			    	rehearsal.setRehearsalName(rehearsalName);
			    	rehearsal.setRehearsalStart(rehearsalStart);
			    	rehearsal.setRehearsalEnd(rehearsalEnd);
			    	rehearsal.setLocation(location);
			    	rehearsal.setAttendanceRequired(attendanceRequired);
			    	
			    	ObjectifyService.ofy().save().entity(rehearsal);
			    }
			    }); 
		  
		  req.setAttribute("status", "updated");
		  RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadRehearsal?seasonId="+seasonId+"&rehearsalId="+rehearsalId);
		  rd.forward(req, resp); 
	  }
}
