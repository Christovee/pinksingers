package com.project.pinksingers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class SaveSeasonServlet extends HttpServlet {

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	Season season;
	
	String seasonName = req.getParameter("seasonName");
	String concertTitle = req.getParameter("concertTitle");
	DateTimeFormatter format = DateTimeFormat.forPattern("yyyy-MM-dd");
	DateTime seasonStart = new DateTime();
	seasonStart = format.parseDateTime(req.getParameter("seasonStart"));
	
	DateTime seasonEnd = new DateTime();
	seasonEnd = format.parseDateTime(req.getParameter("seasonEnd"));
	
	
	season = new Season(seasonName, concertTitle, seasonStart, seasonEnd);
	
	ObjectifyService.ofy().save().entity(season).now();
	
	Long seasonId = season.getSeasonId();
	
	req.setAttribute("seasonId", seasonId);
	req.setAttribute("status", "saved");
	RequestDispatcher rd = getServletContext().getRequestDispatcher("/loadSeason");
	rd.forward(req, resp); 
	}

}
