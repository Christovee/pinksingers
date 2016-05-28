package com.project.pinksingers;

import java.util.Date;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Season {
  @Id private Long seasonId;
  @Index private String seasonName;
  @Index private String concertTitle;
  @Index private Date seasonStart;
  @Index private Date seasonEnd;
  
/**
 * Empty constructor required by objectify 
 */
public Season()
{
}

/**
 * @param seasonId
 * @param seasonName
 * @param concertTitle
 * @param seasonStart
 * @param seasonEnd
 */
public Season(String seasonName, String concertTitle, Date seasonStart, Date seasonEnd) {
	super();
	this.seasonName = seasonName;
	this.concertTitle = concertTitle;
	this.seasonStart = seasonStart;
	this.seasonEnd = seasonEnd;
}
  
  
  public Long getSeasonId() {
	return seasonId;
}

public void setSeasonId(Long seasonId) {
	this.seasonId = seasonId;
}

public String getSeasonName() {
	return seasonName;
}

public void setSeasonName(String seasonName) {
	this.seasonName = seasonName;
}

public String getConcertTitle() {
	return concertTitle;
}

public void setConcertTitle(String concertTitle) {
	this.concertTitle = concertTitle;
}

public Date getSeasonStart() {
	return seasonStart;
}

public void setSeasonStart(Date seasonStart) {
	this.seasonStart = seasonStart;
}

public Date getSeasonEnd() {
	return seasonEnd;
}

public void setSeasonEnd(Date seasonEnd) {
	this.seasonEnd = seasonEnd;
}  

}