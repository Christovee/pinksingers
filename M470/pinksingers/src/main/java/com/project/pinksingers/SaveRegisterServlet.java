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
public class SaveRegisterServlet extends HttpServlet {
	  @Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
	
		  int count = Integer.parseInt(req.getParameter("finalCount"));
		  
		  ArrayList<Register> register = new ArrayList<>();
		  Long memberId;
		  Member member;
		  String attendance;
		  
		  for(int i = 1; i <= count; i++)
		  {
			  memberId = Long.valueOf(req.getParameter("memberId"+i));
			  member = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
			  attendance = req.getParameter("attendance"+i);
			  register.add(new Register(member, attendance));
		  }
		  
		  final ArrayList<Register> finalRegister = register;
		  
		  final Long rehearsalId = Long.valueOf(req.getParameter("rehearsalId"));
		  
		  ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
			    	Rehearsal rehearsal = ObjectifyService.ofy().load().type(Rehearsal.class).id(rehearsalId).now();
			    	
			    	rehearsal.setRegister(finalRegister);
			    	
			    	ObjectifyService.ofy().save().entity(rehearsal);
			    }
		  }); 
		  
		  Long seasonId = Long.valueOf(req.getParameter("seasonId"));
		  String url = "/loadRehearsal?seasonId="+seasonId+"&rehearsalId"+rehearsalId+"&register=true";
		  RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
		  rd.forward(req, resp); 
	  }
}

