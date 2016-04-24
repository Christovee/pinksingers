package com.project.pinksingers;

public enum Section {
	SOPRANO("Soprano"), 
	ALTO("Alto"), 
	TENOR("Tenor"), 
	BASS("Bass");
	
	private final String sectionName;
	
	Section(String sectionName)
	{
		this.sectionName = sectionName;
	}
	
	public static String getSectionName(Section section)
	{
		return section.sectionName;
	}
	
	public static Section convertString(String sectionString)
	{
		Section returnSection = Section.SOPRANO;
		
		switch (sectionString) 
		{ 
			case "Soprano": 
				returnSection = Section.SOPRANO; 
				break; 
			case "Alto": 
				returnSection = Section.ALTO; 
				break; 
			case "Tenor":
				returnSection = Section.TENOR;
				break;
			case "Bass":
				returnSection = Section.BASS;
		}
		
		return returnSection;
	}
}
