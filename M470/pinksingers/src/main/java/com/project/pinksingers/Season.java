package com.project.pinksingers;

import java.util.ArrayList;
import java.util.List;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.VoidWork;
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
  @Index private boolean currentSeason;
  private ArrayList<SeasonMember> seasonMembers = new ArrayList<>();
  

/**
 * Empty constructor required by objectify 
 */
public Season()
{
}

/**
 * Constructor for a brand new season without seasonMembers ArrayList
 * @param seasonId
 * @param seasonName
 * @param concertTitle
 * @param seasonStart
 * @param seasonEnd
 */
public Season(String seasonName, String concertTitle, String seasonStart, String seasonEnd, boolean currentSeason) {
	super();
	this.seasonName = seasonName;
	this.concertTitle = concertTitle;
	this.setSeasonStart(seasonStart); 
	this.setSeasonEnd(seasonEnd);
	this.currentSeason = currentSeason;
}

/**
 * Constructor for a season with seasonMembers ArrayList
 * @param seasonId
 * @param seasonName
 * @param concertTitle
 * @param seasonStart
 * @param seasonEnd
 * @param seasonMembers
 */
public Season(String seasonName, String concertTitle, String seasonStart, String seasonEnd, boolean currentSeason, ArrayList<SeasonMember> seasonMembers) {
	super();
	this.seasonName = seasonName;
	this.concertTitle = concertTitle;
	this.setSeasonStart(seasonStart); 
	this.setSeasonEnd(seasonEnd);
	this.currentSeason = currentSeason;
	this.seasonMembers = seasonMembers;
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

/**
 * @return the seasonMembers
 */
public ArrayList<SeasonMember> getSeasonMembers() {
	return seasonMembers;
}

/**
 * @param seasonMembers the seasonMembers to set
 */
public void setSeasonMembers(ArrayList<SeasonMember> seasonMembers) {
	this.seasonMembers = seasonMembers;
}

/**
* @return the currentSeason
*/
public boolean isCurrentSeason() {
	return currentSeason;
}

/**
* @param currentSeason the currentSeason to set
*/
public void setCurrentSeason(boolean currentSeason) {
	this.currentSeason = currentSeason;
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

// Static method which removes all current season flags in the datastore. 
public static void deleteCurrentSeason()
{
	final List<Season> seasonList = ObjectifyService.ofy().load().type(Season.class).filter("currentSeason", true).order("currentSeason").list();
	
	ObjectifyService.ofy().transact(new VoidWork() {
		public void vrun() {
	
			for(Season season: seasonList)
			{
				Season tempSeason = ObjectifyService.ofy().load().type(Season.class).id(season.getSeasonId()).now();
				tempSeason.setCurrentSeason(false);
				ObjectifyService.ofy().save().entity(tempSeason);
			}
		}

	}); 
}

}