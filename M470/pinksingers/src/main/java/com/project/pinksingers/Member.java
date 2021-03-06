package com.project.pinksingers;

import com.googlecode.objectify.annotation.*;
import com.googlecode.objectify.Key;
import java.lang.String;
import com.google.appengine.api.datastore.Blob;

@Entity
public class Member implements Comparable<Member>{
  @Id private Long memberId;
  @Index private String firstName;
  @Index private String lastName;
  private String photo;
  @Index private String email; 
  private  String password;
  private String funFact;
  @Index private Section section;
  @Index private String subSection;
  @Index private String adminLevel;
  
  public Member()
  {
	  
	  
  }
  
  public Member(String firstName, String lastName, Section section, String subSection, String adminLevel, String email)
  {
	  this.firstName = firstName;
	  this.lastName = lastName;
	  this.section = section;
	  this.subSection = subSection;
	  this.adminLevel = adminLevel;
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
 * @return the firstName
 */
public String getFirstName() {
	return firstName;
}


public String getLastName() {
	return lastName;
}

public void setLastName(String lastName) {
	this.lastName = lastName;
}

public void setFirstName(String firstName) {
	this.firstName = firstName;
}

/**
 * @return the photo
 */
public String getPhoto() {
	return photo;
}

/**
 * @param photo the photo to set
 */
public void setPhoto(String photo) {
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
 * @return the section as String
 */
public String getSection() {
	return Section.getSectionName(this.section);
}


/**
 * @param section the section to set
 */
public void setSection(Section section) {
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

@Override
public int compareTo(Member other) {
	int i = section.compareTo(other.section);
	    if (i != 0) return i;

	    i = subSection.compareTo(other.subSection);
	    if (i != 0) return i;
	    
	    i = firstName.compareTo(other.firstName);
	    if (i != 0) return i;

	    return lastName.compareTo(other.lastName);
	}
}
  
  
  

