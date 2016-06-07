package com.project.pinksingers;

public class SeasonMember {
  
	Long memberId;
	String seasonStatus;
	String seasonSection;
	String seasonSubSection;
  
  public SeasonMember()
  {  
	  
  }
  
  public SeasonMember(Long memberId, String seasonStatus, String seasonSection, String seasonSubSection)
  {
	  this.memberId = memberId;
	  this.seasonStatus = seasonStatus;
	  this.seasonSection = seasonSection;
	  this.seasonSubSection = seasonSubSection;
  }

/**
 * @return the memberId
 */
public Long getMemberId() {
	return memberId;
}

/**
 * @param memberId the memberId to set
 */
public void setMemberId(Long memberId) {
	this.memberId = memberId;
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