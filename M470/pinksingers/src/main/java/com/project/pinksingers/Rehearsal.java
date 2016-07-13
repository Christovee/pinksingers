package com.project.pinksingers;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Rehearsal extends Event {
  
	@Index Boolean attendanceRequired;
	
	public Rehearsal()
	  {  
		  
	  }
	
	public Rehearsal(String name, String start, String end, String location,
			Boolean attendanceRequired) {
		super(name, start, end, location);
		this.attendanceRequired = attendanceRequired;
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

}