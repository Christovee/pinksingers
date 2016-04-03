package com.project.pinksingers;

import java.io.IOException;

import javax.servlet.http.*;

import javax.servlet.ServletException;

@SuppressWarnings("serial")
public class LogoutServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		req.getSession().invalidate();
		resp.sendRedirect("/login.jsp");
		
	}
}