package it.univaq.disim.collectors.domain;

public class Collector {
	
	private int id;
	private String nickname;
	private String email;
	private String nome;
	
	public Collector(int id, String nickname, String email, String nome) {
		this.id = id;
		this.nickname = nickname;
		this.email = email;
		this.nome = nome;
	}
	
	public void setId(int id) {this.id = id;}
	public void setNick(String nickname) {this.nickname = nickname;}
	public void setEmail(String email) {this.email = email;}
	public void setName(String nome) {this.nome=nome;}
	
	public int getId() {return id;}
	public String getNick() {return nickname;}
	public String getEmail() {return email;}
	public String getName() {return nome;}

}
