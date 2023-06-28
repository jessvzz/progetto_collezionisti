package it.univaq.disim.collectors.domain;

import java.sql.Time;

import it.univaq.disim.collectors.domain.Collection.Flag;

public class Track {
	private int id;
	private String ISRC;
	private Time time;
	private String title;
	private Integer disk;
	
	public Track(int id, String ISRC, Time time, String title, Integer disk) {
		this.id = id;
		this.ISRC = ISRC;
		this.time = time;
		this.title = title;
		this.disk = disk;
	}
	
	public void setId(int id) {this.id=id;}
	public void setISRC(String ISRC) {this.ISRC=ISRC;}
	public void setTime(Time time) {this.time=time;}
	public void setTitle(String title) {this.title=title;}
	public void setDisk(Integer disk) {this.disk = disk;}
	
	public int getId() {return id;}
	public String getISRC() {return ISRC;}
	public Time getTime() {return time;}
	public String getTitle() {return title;}
	public Integer getDisk() {return disk;}

}
