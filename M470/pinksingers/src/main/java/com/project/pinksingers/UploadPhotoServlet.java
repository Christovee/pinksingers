package com.project.pinksingers;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.VoidWork;

@SuppressWarnings("serial")
public class UploadPhotoServlet extends HttpServlet {
    private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {

        Map<String, List<BlobKey>> blobs = blobstoreService.getUploads(req);
        List<BlobKey> blobKeys = blobs.get("profilePhoto");

        if (blobKeys == null || blobKeys.isEmpty()) {
            //do nothing
        } else {
        	final Long memberId = Long.valueOf(req.getParameter("memberId"));
            final String blobKey = blobKeys.get(0).getKeyString();
            
            ObjectifyService.ofy().transact(new VoidWork() {
			    public void vrun() {
			    	Member member = ObjectifyService.ofy().load().type(Member.class).id(memberId).now();
			    	
			    	member.setPhoto(blobKey);
			    	
			    	ObjectifyService.ofy().save().entity(member);
			    	}
			 }); 
        }
        resp.sendRedirect("../../index.jsp"); 
    }
}
