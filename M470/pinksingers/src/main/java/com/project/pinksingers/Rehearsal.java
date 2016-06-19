package com.project.pinksingers;

import java.util.ArrayList;

import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormatter;
import org.joda.time.format.ISODateTimeFormat;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Rehearsal implements Comparable<Rehearsal> {
  
	@Id Long rehearsalId;
	@Index String rehearsalName;
	@Index DateTime rehearsalStart;
	DateTime rehearsalEnd;
	String location;
	@Index Boolean attendanceRequired;
	ArrayList<Register> register = new ArrayList<>();
	
	public Rehearsal()
	  {  
		  
	  }
	
  /**
	 * @param rehearsalName
	 * @param rehearsalStart
	 * @param rehearsalEnd
	 * @param location
	 * @param attendanceRequired
	 */
	public Rehearsal(String rehearsalName, String rehearsalStart, String rehearsalEnd, String location,
			Boolean attendanceRequired) {
		super();
		this.rehearsalName = rehearsalName;
		this.setRehearsalStart(rehearsalStart); 
		this.setRehearsalEnd(rehearsalEnd);
		this.location = location;
		this.attendanceRequired = attendanceRequired;
	}

/**
 * @return the rehearsalId
 */
public Long getRehearsalId() {
	return rehearsalId;
}

/**
 * @param rehearsalId the rehearsalId to set
 */
public void setRehearsalId(Long rehearsalId) {
	this.rehearsalId = rehearsalId;
}

/**
 * @return the rehearsalName
 */
public String getRehearsalName() {
	return rehearsalName;
}

/**
 * @param rehearsalName the rehearsalName to set
 */
public void setRehearsalName(String rehearsalName) {
	this.rehearsalName = rehearsalName;
}

/**
 * @return the rehearsalStart
 */
public String getRehearsalStart() {
	return convertDate(rehearsalStart);
}

/**
 * @param rehearsalStart the rehearsalStart to set
 */
public void setRehearsalStart(String rehearsalStart) {
	this.rehearsalStart = convertDate(rehearsalStart);
}

/**
 * @return the rehearsalEnd
 */
public String getRehearsalEnd() {
	return convertDate(rehearsalEnd);
}

/**
 * @param rehearsalEnd the rehearsalEnd to set
 */
public void setRehearsalEnd(String rehearsalEnd) {
	this.rehearsalEnd = convertDate(rehearsalEnd);
}

/**
 * @return the location
 */
public String getLocation() {
	return location;
}

/**
 * @param location the location to set
 */
public void setLocation(String location) {
	this.location = location;
}

/**
 * @return the attendanceRequired
 */
public Boolean getAttendanceRequired() {
	return attendanceRequired;
}

/**
 * @param attendanceRequired the attendanceRequired to set
 */
public void setAttendanceRequired(Boolean attendanceRequired) {
	this.attendanceRequired = attendanceRequired;
}

/**
 * @return the register
 */
public ArrayList<Register> getRegister() {
	return register;
}

/**
 * @param register the register to set
 */
public void setRegister(ArrayList<Register> register) {
	this.register = register;
}

private String convertDate(DateTime dateTime)
{
	DateTimeFormatter format = ISODateTimeFormat.dateHourMinute();
	return format.print(dateTime);
}

private DateTime convertDate(String dateTimeString)
{
	DateTimeFormatter format = ISODateTimeFormat.dateHourMinute();
	DateTime dateTime = new DateTime();
	dateTime = format.parseDateTime(dateTimeString);
	return dateTime;
}

@Override
public int compareTo(Rehearsal other) {
	int i = rehearsalStart.compareTo(other.rehearsalStart);
	    if (i != 0) return i;

	    i = rehearsalName.compareTo(other.rehearsalName);
	    if (i != 0) return i;
	    
	    return rehearsalName.compareTo(other.rehearsalName);
	    
	}
  
  

}