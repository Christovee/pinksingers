package com.project.pinksingers;





import org.joda.time.DateTime;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Season {
  @Id private Long seasonId;
  @Index private String seasonName;
  @Index private String concertTitle;
  @Index private DateTime seasonStart;
  @Index private DateTime seasonEnd;
  
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
public Season(String seasonName, String concertTitle, DateTime seasonStart, DateTime seasonEnd) {
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

public DateTime getSeasonStart() {
	return seasonStart;
}

public void setSeasonStart(DateTime seasonStart) {
	this.seasonStart = seasonStart;
}

public DateTime getSeasonEnd() {
	return seasonEnd;
}

public void setSeasonEnd(DateTime seasonEnd) {
	this.seasonEnd = seasonEnd;
}  

}