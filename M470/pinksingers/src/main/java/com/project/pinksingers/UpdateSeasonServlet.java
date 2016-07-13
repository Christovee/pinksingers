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
public class UpdateSeasonServlet extends HttpServlet {
	  @Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	
		  final Long seasonId = Long.valueOf(req.getParameter("seasonId"));
		  final String seasonName = req.getParameter("seasonName");
		  final String concertTitle = req.getParameter("concertTitle");
		  final String seasonStart = req.getParameter("seasonStart");
		  final String seasonEnd = req.getParameter("seasonEnd");
		  final boolean currentSeason = Boolean.valueOf(req.getParameter("currentSeason"));
		  
		  if(currentSeason)
		  {
			  Season.deleteCurrentSeason();
		  }
		 
		  
		  ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
			    	Season season = ObjectifyService.ofy().load().type(Season.class).id(seasonId).now();
			    	
			    	season.setName(seasonName);
			    	season.setConcertTitle(concertTitle);
			    	season.setStart(seasonStart);
			    	season.setEnd(seasonEnd);
			    	season.setCurrentSeason(currentSeason);
			    	
			    	ObjectifyService.ofy().save().entity(season);
			    }
			    }); 
		  
		  ArrayList<Long> previousSeasonIds = Season.getPreviousSeasonIds(seasonId);
		  
		  String prev0 = String.valueOf(previousSeasonIds.get(0));
		  String prev1 = String.valueOf(previousSeasonIds.get(1));
		  
		  req.setAttribute("seasonId", seasonId);
		  req.setAttribute("status", "updated");
		  RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadSeason?prev0="+prev0+"&prev1="+prev1);
		  System.out.println("/loadSeason?prev0="+prev0+"&prev1="+prev1);
		  rd.forward(req, resp); 
	  }
}
