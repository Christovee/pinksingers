package com.project.pinksingers;





import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

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
public Season(String seasonName, String concertTitle, String seasonStart, String seasonEnd) {
	super();
	this.seasonName = seasonName;
	this.concertTitle = concertTitle;
	this.setSeasonStart(seasonStart); 
	this.setSeasonEnd(seasonEnd);
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

public String getSeasonStart() {
	return convertDate(seasonStart);
}

public void setSeasonStart(String seasonStart) {
	this.seasonStart = convertDate(seasonStart);
}

public String getSeasonEnd() {
	return convertDate(seasonEnd);
}

public void setSeasonEnd(String seasonEnd) {
	this.seasonEnd = convertDate(seasonEnd);
}  

private String convertDate(DateTime dateTime)
{
	DateTimeFormatter format = ISODateTimeFormat.date();
	return format.print(dateTime);
}

private DateTime convertDate(String dateTimeString)
{
	DateTimeFormatter format = ISODateTimeFormat.date();
	DateTime dateTime = new DateTime();
	dateTime = format.parseDateTime(dateTimeString);
	return dateTime;
}

}