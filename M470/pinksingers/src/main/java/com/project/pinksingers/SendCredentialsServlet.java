package com.project.pinksingers;

import java.io.IOException;

import javax.servlet.http.*;

import javax.servlet.ServletException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.VoidWork;

import org.apache.commons.lang3.RandomStringUtils;

@SuppressWarnings("serial")
public class SendCredentialsServlet extends HttpServlet {
	  @Override
	  public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
		  
		  final Long memberId = Long.valueOf(req.getParameter("memberId"));
		  final String tempPassword = RandomStringUtils.randomAlphanumeric(8).toUpperCase();
		  
		  Member member = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
		  
		  String email = member.getEmail();
	      String name = member.getFirstName()+" "+member.getLastName();
		  
		  ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
		  
			    	Member tempMember = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
			    	
			    	tempMember.setPassword(tempPassword);
			    	ObjectifyService.ofy().save().entity(tempMember).now();
		    	}
		    }); 
		  
		  
		  
		  Properties props = new Properties();
	      Session session = Session.getDefaultInstance(props, null);
	      

	     String msgBody = "Your temp password is "+tempPassword;

	        try {
	            Message msg = new MimeMessage(session);
	            msg.setFrom(new InternetAddress("chris.viveash@pinksingers.co.uk", "Pink Singers Admin"));
	            msg.addRecipient(Message.RecipientType.TO,
	                             new InternetAddress(email, name));
	            msg.setSubject("Your pinksingers account has been set up");
	            msg.setText(msgBody);
	            Transport.send(msg);

	        } catch (AddressException e) {
	            // ...
	        } catch (MessagingException e) {
	            // ...
	        } 
	
	  }	

}
