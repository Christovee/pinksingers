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

public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig config) throws ServletException {
    
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        
       boolean isAdmin = session != null && session.getAttribute("sessionAccess").equals("admin");
       
        
        if (isAdmin) {
            chain.doFilter(request, response);
        } else {
    	   response.sendRedirect("/index.jsp");
		} 
    }

    @Override
    public void destroy() {
    }

}