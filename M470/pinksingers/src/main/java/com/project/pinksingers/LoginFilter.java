package com.project.pinksingers;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginFilter implements Filter {

    @Override
    public void init(FilterConfig config) throws ServletException {
    
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        
        boolean loggedIn = session != null && session.getAttribute("sessionMemberId") != null;
        boolean loginRequest = request.getRequestURI().equals("/login.jsp") || request.getRequestURI().equals("/login") ;
        
       if (loggedIn || loginRequest) {
            chain.doFilter(request, response);
        } else {
    	   response.sendRedirect("/login.jsp");
		} 
    }

    @Override
    public void destroy() {
    }

}