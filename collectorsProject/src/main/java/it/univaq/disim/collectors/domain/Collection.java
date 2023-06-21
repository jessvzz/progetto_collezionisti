package it.univaq.disim.collectors.domain;

public class Collection {
	private int id;
	private String name;
	private Flag flag;

	
	
	public enum Flag{
		PUBBLICO, PRIVATO;
	}
	
	public void setId(int id) {this.id = id;}
	public void setName(String name) {this.name = name;}
	public void setFlag(Flag flag) {this.flag = flag;}
}
