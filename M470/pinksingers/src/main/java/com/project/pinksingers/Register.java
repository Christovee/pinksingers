package com.project.pinksingers;

import com.googlecode.objectify.Ref;
import com.googlecode.objectify.annotation.Load;

public class Register {
  
	@Load Ref<Member> member;
	String attendance;
  
  public Register()
  {  
	  
  }
  
  public Register(Member member, String attendance)
  {
	  this.setMember(member);
	  this.attendance = attendance;
  }

/**
 * @return the memberId
 */
public Member getMember() {
	
	return member.getValue();
}

/**
 * @param memberId the memberId to set
 */
public void setMember(Member m) {
	member = Ref.create(m);
}

/**
 * @return the attendance
 */
public String getAttendance() {
	return attendance;
}

/**
 * @param attendance the attendance to set
 */
public void setAttendance(String attendance) {
	this.attendance = attendance;
}



}