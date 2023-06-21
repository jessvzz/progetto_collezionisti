package it.univaq.disim.collectors.domain;

public class Genre {
	private int id;
	private String name;
	
	public Genre(int id, String name) {
		this.id = id;
		this.name = name;
	}
	
	public void setId(int id) {this.id=id;}
	public void setName(String name) {this.name=name;}
	
	public int getId() {return id;}
	public String getName() {return name;}

}
