package com.project.pinksingers;

import com.googlecode.objectify.Ref;
import com.googlecode.objectify.annotation.Load;

public class SeasonMember {
  
	@Load Ref<Member> member;
	String seasonStatus;
	String seasonSection;
	String seasonSubSection;
  
  public SeasonMember()
  {  
	  
  }
  
  public SeasonMember(Member member, String seasonStatus, String seasonSection, String seasonSubSection)
  {
	  this.setMember(member);
	  this.seasonStatus = seasonStatus;
	  this.seasonSection = seasonSection;
	  this.seasonSubSection = seasonSubSection;
  }

/**
 * @return the memberId
 */
public Member getMember() {
	
	return member.getValue();
}

/**
 * @param memberId the memberId to set
 */
public void setMember(Member m) {
	member = Ref.create(m);
}


/**
 * @return the seasonStatus
 */
public String getSeasonStatus() {
	return seasonStatus;
}

/**
 * @param seasonStatus the seasonStatus to set
 */
public void setSeasonStatus(String seasonStatus) {
	this.seasonStatus = seasonStatus;
}

/**
 * @return the seasonSection
 */
public String getSeasonSection() {
	return seasonSection;
}

/**
 * @param seasonSection the seasonSection to set
 */
public void setSeasonSection(String seasonSection) {
	this.seasonSection = seasonSection;
}

/**
 * @return the seasonSubSection
 */
public String getSeasonSubSection() {
	return seasonSubSection;
}

/**
 * @param seasonSubSection the seasonSubSection to set
 */
public void setSeasonSubSection(String seasonSubSection) {
	this.seasonSubSection = seasonSubSection;
}


}