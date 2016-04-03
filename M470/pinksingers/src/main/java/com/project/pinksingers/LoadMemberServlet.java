package com.project.pinksingers;

import java.io.IOException;

import javax.servlet.http.*;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;

import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.images.ImagesServiceFactory;
import com.google.appengine.api.images.ImagesService;
import com.google.appengine.api.images.ServingUrlOptions;
import com.googlecode.objectify.ObjectifyService;



public class LoadMemberServlet extends HttpServlet {
	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		//Check if parameter is null isn't empty
		if(req.getParameter("memberId") == null)
		{
			resp.sendRedirect("../index.jsp"); 
		}else{
			Long memberId = Long.valueOf(req.getParameter("memberId"));
			doCode(req, resp, memberId);
		}	
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		Long memberId = null;
				
		if(req.getAttribute("memberId") == null)
		{
			memberId = Long.valueOf(req.getParameter("memberId"));
		}else{
			memberId = (Long)req.getAttribute("memberId");
		}
		
		doCode(req, resp, memberId);
				
		
	}
	
	public void doCode(HttpServletRequest req, HttpServletResponse resp, Long memberId) throws IOException, ServletException 
	{
		Member member = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
		
		req.setAttribute("member", member);
		
		String photoKey = member.getPhoto();
		BlobKey blobKey;
		
		if(photoKey == null)
		{
			blobKey = new BlobKey("I2zEtg9aZtUTRNnsRHDi9Q");
		}else{
			blobKey = new BlobKey(photoKey);
		}
		
		ImagesService imagesService = ImagesServiceFactory.getImagesService();
		ServingUrlOptions options = ServingUrlOptions.Builder
				.withBlobKey(blobKey)
                .imageSize(150) // Optional.
                .crop(true); // Optional.
		
		String servingUrl = imagesService.getServingUrl(options);
		
		req.setAttribute("servingUrl", servingUrl);
		
		String forwardingPage = "";
		
		String action = "";
		
		if(req.getParameter("action") != null)
		{
			action = req.getParameter("action");
		}
		
		if(req.getAttribute("action") != null)
		{
			action = req.getAttribute("action").toString();
		}
		
		if(action.equals("editProfile"))
		{
			BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
			String uploadUrl = blobstoreService.createUploadUrl("/uploadPhoto");
			req.setAttribute("uploadUrl", uploadUrl);
			forwardingPage = "/memberUpdate.jsp";
			
		}else{
		
			if(req.getAttribute("status") == null)
			{
				forwardingPage = "/memberView.jsp";
			}else{
				forwardingPage = "/admin/memberEdit.jsp";
			}
		}		
		RequestDispatcher rd = req.getRequestDispatcher(forwardingPage);
		rd.forward(req, resp); 
	}
}