package it.univaq.disim.collectors.domain;

import it.univaq.disim.collectors.domain.Collection.Flag;

public class Label {
	private int id;
	private int p_iva;
	private String name;
	
	public Label(int id, int p_iva, String name) {
		this.id = id;
		this.p_iva = p_iva;
		this.name = name;
	}
	
	public void setID(int id) {this.id=id;}
	public void setPiva(int p_iva) {this.p_iva=p_iva;}
	public void setName(String name) {this.name=name;}
	
	private int getId() {return id;}
	private int getPiva() {return p_iva;}
	private String getName() {return name;}

}
