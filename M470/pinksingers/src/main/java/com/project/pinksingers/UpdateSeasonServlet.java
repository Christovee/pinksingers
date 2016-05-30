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
public class UpdateSeasonServlet extends HttpServlet {
	  @Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	
		  final Long seasonId = Long.valueOf(req.getParameter("seasonId"));
		  final String seasonName = req.getParameter("seasonName");
		  final String concertTitle = req.getParameter("concertTitle");
		  final String seasonStart = req.getParameter("seasonStart");
		  final String seasonEnd = req.getParameter("seasonEnd");
		 
		  
		  ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
			    	Season season = ObjectifyService.ofy().load().type(Season.class).id(seasonId).now();
			    	
			    	season.setSeasonName(seasonName);
			    	season.setConcertTitle(concertTitle);
			    	season.setSeasonStart(seasonStart);
			    	season.setSeasonEnd(seasonEnd);
			    	
			    	ObjectifyService.ofy().save().entity(season);
			    }
			    }); 
		  
		  req.setAttribute("seasonId", seasonId);
		  req.setAttribute("status", "updated");
		  RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadSeason");
		  rd.forward(req, resp); 
	  }
}
