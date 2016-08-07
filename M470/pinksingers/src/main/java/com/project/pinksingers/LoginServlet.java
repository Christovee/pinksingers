package com.project.pinksingers;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.*;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;

import com.googlecode.objectify.ObjectifyService;

@SuppressWarnings("serial")
public class LoginServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		//Send any Get requests to the Login page. 
		resp.sendRedirect("/login.jsp");
		
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
							
		List<Member> memberList = ObjectifyService.ofy().load().type(Member.class).list();
		
		String email = req.getParameter("email").toString().toLowerCase();
		String password = req.getParameter("password").toString().toLowerCase();
		String access = "";
		String firstName = "";
		Long memberId = 0L;
		boolean userFlag = false;
		boolean passwordFlag = false;
		
		for (Member member : memberList) {
			if(member.getEmail().toLowerCase().equals(email))
			{
				userFlag = true;
				if(member.getPassword().toLowerCase().equals(password))
				{
					passwordFlag = true;
					access = member.getAdminLevel();
					firstName = member.getFirstName();
					memberId = member.getMemberId();
					
				}
				
			}
		}
		RequestDispatcher rd;
		if(userFlag)
		{
			if(passwordFlag)
			{
				HttpSession session = req.getSession();
			    session.setAttribute("sessionAccess", access);
			    session.setAttribute("sessionFirstName", firstName);
			    session.setAttribute("sessionMemberId", memberId);
				rd = getServletContext().getRequestDispatcher("/loadIndex");
			}else{
				req.setAttribute("status", "password");
				rd = getServletContext().getRequestDispatcher("/login.jsp");
			}
		}else{
			req.setAttribute("status", "userName");
			rd = getServletContext().getRequestDispatcher("/login.jsp");
		}
		rd.forward(req, resp); 
	}
}
