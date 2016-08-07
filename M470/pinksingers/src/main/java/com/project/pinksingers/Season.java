package com.project.pinksingers;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Ref;
import com.googlecode.objectify.VoidWork;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Load;

@Entity
public class Season extends Occurrence{
 
  @Index private String concertTitle;
  @Index private boolean currentSeason;
  private ArrayList<SeasonMember> seasonMembers = new ArrayList<>();
  @Load private ArrayList<Ref<Rehearsal>> rehearsals = new ArrayList<>();
  

/**
 * Empty constructor required by objectify 
 */
public Season()
{
}

/**
 * Constructor for a brand new season without seasonMembers ArrayList
 */
public Season(String name, String concertTitle, String start, String end, boolean currentSeason) {
	super(name, start, end);
	this.concertTitle = concertTitle;
	this.currentSeason = currentSeason;
}

/**
 * Constructor for a season with seasonMembers ArrayList
 */
public Season(String name, String concertTitle, String start, String end, boolean currentSeason, ArrayList<SeasonMember> seasonMembers) {
	super(name, start, end);
	this.concertTitle = concertTitle;
	this.currentSeason = currentSeason;
	this.seasonMembers = seasonMembers;
}

public String getConcertTitle() {
	return concertTitle;
}

public void setConcertTitle(String concertTitle) {
	this.concertTitle = concertTitle;
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

/**
 * @return the rehearsal
 */
public ArrayList<Rehearsal> getRehearsals() {
	ArrayList<Rehearsal> rehearsals = new ArrayList<>();
	Iterator <Ref<Rehearsal>> it = this.rehearsals.iterator();
	
	while(it.hasNext())
	{
		rehearsals.add(it.next().getValue());
	}
	return rehearsals;
}

/**
 * @param rehearsal the rehearsal to set
 */
public void setRehearsals(ArrayList<Rehearsal> rehearsals) {
	Iterator<Rehearsal> it = rehearsals.iterator();
	
	while(it.hasNext())
	{
		this.addRehearsal(it.next());
	}
}

//Converts a rehearsal to a reference and add it to the array of rehearsals. 
public void addRehearsal(Rehearsal rehearsal)
{
	this.rehearsals.add(Ref.create(rehearsal));
}

public static Season getCurrentSeason()
{
	 Season season = ObjectifyService.ofy().load().type(Season.class).filter("currentSeason", true).first().now();
	 
	 return season;
	
}

// Static method which removes all current season flags in the datastore. 
public static void deleteCurrentSeason()
{
	final List<Season> seasonList = ObjectifyService.ofy().load().type(Season.class).filter("currentSeason", true).order("currentSeason").list();
	
	ObjectifyService.ofy().transact(new VoidWork() {
		public void vrun() {
	
			for(Season season: seasonList)
			{
				Season tempSeason = ObjectifyService.ofy().load().type(Season.class).id(season.getId()).now();
				tempSeason.setCurrentSeason(false);
				ObjectifyService.ofy().save().entity(tempSeason);
			}
		}

	}); 
}

// Static method to return previous Ids chronologically to passed seasonId. 
public static ArrayList<Long> getPreviousSeasonIds(Long seasonId)
{
	List<Season> seasonList  = ObjectifyService.ofy().load().type(Season.class).order("-start").list();
	ArrayList<Long> prevSeasonIds = new ArrayList<>();
	
	//Flag set to true once seasonId is matched to seasonId in season list
	boolean matchFlag = false;
	
	for(Season season: seasonList)
	{
		//If seasonId matches or has previously matched enter if statement. 
		if(matchFlag || seasonId.equals(season.getId()))
		{
			matchFlag = true;
			//If seasonId has previous matched but doesn't currently match add to array. 
			if(!seasonId.equals(season.getId()))
			{
				prevSeasonIds.add(season.getId());
			}
		}
	}
	
	//Add to zero value Long objects to ensure array isn't empty. 
	prevSeasonIds.add(0L);
	prevSeasonIds.add(0L);
	
	//return array of previous seasons (most recent first). 
	return prevSeasonIds;
}

}