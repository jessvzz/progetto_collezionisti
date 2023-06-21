package it.univaq.disim.collectors.domain;

public class Collector {
	
	private int id;
	private String nickname;
	private String email;
	private String name;
	
	public Collector(int id, String nickname, String email) {
		this.id = id;
		this.nickname = nickname;
		this.email = email;
	}
	public void setId(int id) {this.id = id;}
	public void setNick(String nickname) {this.nickname = nickname;}
	public void setEmail(String email) {this.email = email;}
	public String getName() {return name;}
	
}
