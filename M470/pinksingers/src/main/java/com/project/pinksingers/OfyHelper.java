package com.project.pinksingers;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import com.googlecode.objectify.ObjectifyService;
import com.sappenin.objectify.translate.UTCReadableInstantDateTranslatorFactory;

/**
 * OfyHelper, a ServletContextListener, is setup in web.xml to run before a JSP is run.  This is
 * required to let JSP's access Ofy.
 **/
public class OfyHelper implements ServletContextListener {
  public void contextInitialized(ServletContextEvent event) {
    // This will be invoked as part of a warmup request, or the first user request if no warmup
    // request.
	
	ObjectifyService.factory().getTranslators().add(new UTCReadableInstantDateTranslatorFactory());
    ObjectifyService.register(Member.class);
    ObjectifyService.register(Season.class);
    ObjectifyService.register(Rehearsal.class);
    
  }

  public void contextDestroyed(ServletContextEvent event) {
    // App Engine does not currently invoke this method.
  }
}