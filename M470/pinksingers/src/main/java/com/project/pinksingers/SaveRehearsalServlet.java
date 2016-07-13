package com.project.pinksingers;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Ref;
import com.googlecode.objectify.VoidWork;

@SuppressWarnings("serial")
public class SaveRehearsalServlet extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

		//Get parameters from form. 
		String rehearsalName = req.getParameter("rehearsalName");
		String rehearsalStart = req.getParameter("rehearsalStart");
		String rehearsalEnd = req.getParameter("rehearsalEnd");
		String location = req.getParameter("location");
		boolean attendanceRequired = Boolean.valueOf(req.getParameter("attendanceRequired"));	
		final Long seasonId = Long.valueOf(req.getParameter("seasonId"));
		
		final Rehearsal rehearsal = new Rehearsal(rehearsalName, rehearsalStart, rehearsalEnd, location, attendanceRequired);
	
		ObjectifyService.ofy().save().entity(rehearsal).now();
		
		Long rehearsalId = rehearsal.getId();
		
		ObjectifyService.ofy().transact(new VoidWork() {
		    public void vrun() {
		    	Season season = ObjectifyService.ofy().load().type(Season.class).id(seasonId).now();
		    	
		    	season.addRehearsal(rehearsal);
		    	
		    	ObjectifyService.ofy().save().entity(season);
		    }
		    }); 
	
		req.setAttribute("seasonId", seasonId);
		req.setAttribute("status", "saved");
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadRehearsal?rehearsalId="+rehearsalId);
		rd.forward(req, resp); 
	}

}
