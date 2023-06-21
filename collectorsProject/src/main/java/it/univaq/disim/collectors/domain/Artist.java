package it.univaq.disim.collectors.domain;

import it.univaq.disim.collectors.domain.Collection.Flag;

public class Artist {
	private int id;
	private String stage_name;
	private String name;
	private String surname;
	private boolean group; 
	
	public Artist(int id, String stage_name) {
		this.id = id;
		this.stage_name = stage_name;
	}
	
	public void setId(int id) {this.id = id;}
	public void setStagename(String stage_name) {this.stage_name = stage_name;}
	public void setName(String name) {this.name = name;}
	public void setSurname(String surname) {this.surname = surname;}
	public void setGroup(boolean group) {this.group = group;}
	
	public int getId() {return id;}
	public String getStagename() {return stage_name;}
	public String getName() {return name;}
	public String getSurname() {return surname;}
	public boolean getGroup() {return group;}
	
}
