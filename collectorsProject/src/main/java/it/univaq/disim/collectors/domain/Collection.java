package it.univaq.disim.collectors.domain;

public class Collection {
	private int id;
	private String name;
	private Flag flag;
	private Collector collector;
	
	
	public enum Flag{
		PUBBLICO, PRIVATO;
	}
	
	public Collection(int id, String name, Flag flag, Collector collector) {
		this.id = id;
		this.name = name;
		this.flag = flag;
		this.collector = collector;
	}
	
	public void setId(int id) {this.id = id;}
	public void setName(String name) {this.name = name;}
	public void setFlag(Flag flag) {this.flag = flag;}
	public void setCollector(Collector collector) {this.collector = collector;}
	
	public int getId() {return id;}
	public String getName() {return name;}
	public Flag getFlag() {return flag;}
	public Collector getCollector() {return collector;}
	
}
