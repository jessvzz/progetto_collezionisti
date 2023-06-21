package it.univaq.disim.collectors.domain;

import it.univaq.disim.collectors.domain.Collection.Flag;

public class Disk {
	private int id;
	private String titolo;
	private int anno;
	private Artist artist;
	private Label label;
	private Collector collector;
	private Genre genre;
	
	
	public Disk(int id, String titolo, int anno, Artist artist, Label label, Collector collector, Genre genre) {
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
	public void setArtist(Artist artist) {this.artist = artist;}
	public void setLabel(Label label) {this.label = label;}
	public void setCollector(Collector collector) {this.collector = collector;}
	public void setGenre(Genre genre) {this.genre = genre;}
	
	public int getId() {return id;}
	public String getTitle() {return titolo;}
	public int getYear() {return anno;}
	public Artist getArtist() {return artist;}
	public Label getLabel() {return label;}
	public Collector getCollector() {return collector;}
	public Genre getGenre() {return genre;}

}
