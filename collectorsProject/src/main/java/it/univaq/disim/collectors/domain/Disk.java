package it.univaq.disim.collectors.domain;

import it.univaq.disim.collectors.domain.Collection.Flag;

public class Disk {
	private int id;
	private String titolo;
	private int anno;
	private int artist;
	private int label;
	private int collector;
	private int genre;
	
	
	public Disk(int id, String titolo, int anno, int artist, int label, int collector, int genre) {
		this.id = id;
		this.titolo = titolo;
		this.anno = anno;
		this.artist = artist;
		this.label = label;
		this.collector = collector;
		this.genre = genre;
	}
	
	public void setId(int id) {this.id = id;}
	public void setTitle(String titolo) {this.titolo = titolo;}
	public void setYear(int anno) {this.anno = anno;}
	public void setArtist(int artist) {this.artist = artist;}
	public void setLabel(int label) {this.label = label;}
	public void setCollector(int collector) {this.collector = collector;}
	public void setGenre(int genre) {this.genre = genre;}
	
	public int getId() {return id;}
	public String getTitle() {return titolo;}
	public int getYear() {return anno;}
	public int getArtist() {return artist;}
	public int getLabel() {return label;}
	public int getCollector() {return collector;}
	public int getGenre() {return genre;}

}
