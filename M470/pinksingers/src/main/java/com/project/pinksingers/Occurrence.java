package com.project.pinksingers;

import java.util.Date;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

public abstract class Occurrence {

  @Id private Long id;
  @Index private String name;
  @Index private DateTime start;
  @Index private DateTime end;
  
 public Occurrence()
 {
	 
 }

/**
 * Constructor for a brand new season without seasonMembers ArrayList
 * @param id
 * @param name
 * @param start
 * @param end
 */
public Occurrence(String name, String start, String end) {
	super();
	this.name = name;
	this.setStart(start); 
	this.setEnd(end);
}
  
public Long getId() {
	return id;
}

public void setId(Long id) {
	this.id = id;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public String getStart() {
	return convertDate(start);
}

public Date getJavaStart() {
	return start.toDate();
}

public void setStart(String start) {
	this.start = convertDate(start);
}

public String getEnd() {
	return convertDate(end);
}

public Date getJavaEnd(){
	return end.toDate();
}


public void setEnd(String end) {
	this.end = convertDate(end);
}  

private String convertDate(DateTime dateTime)
{
	DateTimeFormatter format;
	if(this instanceof Season)
	{
		format = ISODateTimeFormat.date();
	}else{
		format = ISODateTimeFormat.dateHourMinute();
	}
	
	return format.print(dateTime);
}

private DateTime convertDate(String dateTimeString)
{
	DateTimeFormatter format;
	if(this instanceof Season)
	{
		format = ISODateTimeFormat.date();
	}else{
		format = ISODateTimeFormat.dateHourMinute();
	}
	DateTime dateTime = new DateTime();
	dateTimeString = dateTimeString.replace("/", "-");
	dateTime = format.parseDateTime(dateTimeString);
	return dateTime;
}



}