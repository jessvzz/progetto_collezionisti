package it.univaq.disim.collectors.domain;

import it.univaq.disim.collectors.domain.Collection.Flag;

public class Type {
	private int id;
	private String name;
	
	public Type(int id, String name) {
		this.id = id;
		this.name = name;
	}
	
	public void setId(int id) {this.id=id;}
	public void setType(String name) {this.name=name;}
	
	public int getId() {return id;}
	public String getType() {return name;}

}
