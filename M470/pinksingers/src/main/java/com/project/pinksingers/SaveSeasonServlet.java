package com.project.pinksingers;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.VoidWork;

@SuppressWarnings("serial")
public class SaveSeasonServlet extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

		//Get parameters from form. 
		String seasonName = req.getParameter("seasonName");
		String concertTitle = req.getParameter("concertTitle");
		String seasonStart = req.getParameter("seasonStart");
		String seasonEnd = req.getParameter("seasonEnd");
		boolean currentSeason = Boolean.valueOf(req.getParameter("currentSeason"));	
		
		//if currentSeason is true, make sure all other seasons are set to false first. 
		if(currentSeason)
		{
			Season.deleteCurrentSeason();
		}
	
	
		Season season = new Season(seasonName, concertTitle, seasonStart, seasonEnd, currentSeason);
	
		ObjectifyService.ofy().save().entity(season).now();
	
		Long seasonId = season.getId();
	
		req.setAttribute("seasonId", seasonId);
		req.setAttribute("status", "saved");
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadSeason");
		rd.forward(req, resp); 
	}

}
