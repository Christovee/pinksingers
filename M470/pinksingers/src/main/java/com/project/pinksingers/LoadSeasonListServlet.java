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
public class LoadSeasonListServlet extends HttpServlet {
	@Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		
		List<Season> seasonList = ObjectifyService.ofy().load().type(Season.class).order("-seasonStart").list();
	
		req.setAttribute("seasonList", seasonList);
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin/seasonList.jsp");
		
		rd.forward(req, resp); 
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		  
		  //Redirect Get requests to post request
		  	doPost(req, resp);
	}
}