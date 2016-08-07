package com.project.pinksingers;

import java.util.ArrayList;

import org.joda.time.DateTime;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.VoidWork;
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

public static Rehearsal getNextRehearsal()
{
	Rehearsal rehearsal = ObjectifyService.ofy().load().type(Rehearsal.class).filter("start >=", DateTime.now()).first().now();
	 
	return rehearsal;
	
}

public String getMemberAttendance(Long memberId)
{
	String attendance = "";
	
	for(Register r:register)
	{
		if(r.getMember().getMemberId() == memberId)
		{
			attendance = r.getAttendance();
		}
	}
	
	return attendance;
}



}