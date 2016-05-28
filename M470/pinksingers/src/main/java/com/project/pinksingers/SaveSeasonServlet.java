package com.project.pinksingers;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class SaveSeasonServlet extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	Season season;
	
	String seasonName = req.getParameter("seasonName");
	String concertTitle = req.getParameter("concertTitle");
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	Date seasonStart = new Date();
	try {
		seasonStart = format.parse(req.getParameter("seasonStart"));
	} catch (ParseException e) {
		e.printStackTrace();
	}
	Date seasonEnd = new Date();
	try {
		seasonEnd = format.parse(req.getParameter("seasonEnd"));
	} catch (ParseException e) {
		e.printStackTrace();
	}
	
	season = new Season(seasonName, concertTitle, seasonStart, seasonEnd);
	
	ObjectifyService.ofy().save().entity(season).now();
	
	Long seasonId = season.getSeasonId();
	
	req.setAttribute("seasonId", seasonId);
	req.setAttribute("status", "saved");
	RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadSeason");
	rd.forward(req, resp); 
	}

}
