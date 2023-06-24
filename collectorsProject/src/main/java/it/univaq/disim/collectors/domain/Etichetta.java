package it.univaq.disim.collectors.domain;

import it.univaq.disim.collectors.domain.Collection.Flag;

public class Etichetta {
	private int id;
	private String p_iva;
	private String name;
	
	public Etichetta(int id, String p_iva, String name) {
		this.id = id;
		this.p_iva = p_iva;
		this.name = name;
	}
	
	public void setID(int id) {this.id=id;}
	public void setPiva(String p_iva) {this.p_iva=p_iva;}
	public void setName(String name) {this.name=name;}
	
	public int getId() {return id;}
	public String getPiva() {return p_iva;}
	public String getName() {return name;}

}
