package com.project.pinksingers;

import com.googlecode.objectify.annotation.*;
import com.googlecode.objectify.Key;
import java.lang.String;
import com.google.appengine.api.datastore.Blob;

@Entity
public class Member {
  @Id private Long memberId;
  @Index private String name;
  private Blob photo;
  @Index private String email; 
  private  String password;
  private String funFact;
  @Index private String section;
  @Index private String subSection;
  @Index private String adminLevel;
  
  public Member()
  {
	  
	  
  }
  
  public Member(String name, String email)
  {
	  this.name = name;
	  this.email = email;
  }

/**
 * @return the memberId
 */
public Long getMemberId() {
	return memberId;
}

/**
 * @return the password
 */
public String getPassword() {
	return password;
}

/**
 * @param password the password to set
 */
public void setPassword(String password) {
	this.password = password;
}


/**
 * @return the name
 */
public String getName() {
	return name;
}

/**
 * @param name the name to set
 */
public void setName(String name) {
	this.name = name;
}

/**
 * @return the photo
 */
public Blob getPhoto() {
	return photo;
}

/**
 * @param photo the photo to set
 */
public void setPhoto(Blob photo) {
	this.photo = photo;
}

/**
 * @return the email
 */
public String getEmail() {
	return email;
}

/**
 * @param email the email to set
 */
public void setEmail(String email) {
	this.email = email;
}

/**
 * @return the funFact
 */
public String getFunFact() {
	return funFact;
}

/**
 * @param funFact the funFact to set
 */
public void setFunFact(String funFact) {
	this.funFact = funFact;
}

/**
 * @return the section
 */
public String getSection() {
	return section;
}

/**
 * @param section the section to set
 */
public void setSection(String section) {
	this.section = section;
}

/**
 * @return the subSection
 */
public String getSubSection() {
	return subSection;
}

/**
 * @param subSection the subSection to set
 */
public void setSubSection(String subSection) {
	this.subSection = subSection;
}

/**
 * @return the adminLevel
 */
public String getAdminLevel() {
	return adminLevel;
}

/**
 * @param adminLevel the adminLevel to set
 */
public void setAdminLevel(String adminLevel) {
	this.adminLevel = adminLevel;
}
  
  
  
}
