package com.project.pinksingers;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.*;

import org.joda.time.DateTime;
import org.joda.time.ReadableInstant;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;

import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ServingUrlOptions;
import com.googlecode.objectify.ObjectifyService;



@SuppressWarnings("serial")
public class LoadSeasonServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		//Check if parameter is null isn't empty
		if(req.getParameter("memberId") == null)
		{
			resp.sendRedirect("../index.jsp"); 
		}else{
			Long seasonId = Long.valueOf(req.getParameter("seasonId"));
			doCode(req, resp, seasonId);
		}	
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		Long seasonId = null;
				
		if(req.getAttribute("seasonId") == null)
		{
			seasonId = Long.valueOf(req.getParameter("seasonId"));
		}else{
			seasonId = (Long)req.getAttribute("seasonId");
		}
		
		doCode(req, resp, seasonId);
				
		
	}
	
	public void doCode(HttpServletRequest req, HttpServletResponse resp, Long seasonId) throws IOException, ServletException 
	{
		Season season = ObjectifyService.ofy().load().type(Season.class).id(seasonId).now();
		
		req.setAttribute("season", season);
		
		String seasonStart = convertDate(req.getParameter("seasonStart"));
		
		req.setAttribute("seasonStart", seasonStart);

		String seasonEnd = convertDate(req.getParameter("seasonEnd"));
		
		req.setAttribute("seasonEnd", seasonEnd);
		
		RequestDispatcher rd = req.getRequestDispatcher("/admin/seasonEdit.jsp");
		rd.forward(req, resp); 
	}
	
	private String convertDate(String dateTime)
	{
		DateTimeFormatter format = ISODateTimeFormat.date();
		DateTime jodaTime = format.parseDateTime(dateTime);
		return format.print(jodaTime);
	}
}