package com.project.pinksingers;

import java.util.ArrayList;

import com.googlecode.objectify.annotation.Entity;

@Entity
public class Event extends Occurrence implements Comparable<Event> {
  
	String location;
	ArrayList<Register> register = new ArrayList<>();
	
	public Event()
	{  
		  
	}
	
	public Event(String name, String start, String end, String location) {
		super(name, start, end);
		this.location = location;
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

@Override
public int compareTo(Event other) {
	int i = this.getStart().compareTo(other.getStart());
	    if (i != 0) return i;

	    i = this.getName().compareTo(other.getName());
	    if (i != 0) return i;
	    
	    return this.getName().compareTo(other.getName());
	    
	}
}