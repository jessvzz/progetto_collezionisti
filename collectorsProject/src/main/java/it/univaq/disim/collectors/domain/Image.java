package it.univaq.disim.collectors.domain;

public class Image {
	private int id;
	private String name;
	private String dimension;
	private String format;
	private String url;
	private String collocation;
	private Disk disk;
	
	public Image(int id, String url, Disk disk) {
		this.id = id;
		this.url = url;
		this.disk = disk;
	}
	
	public void setId(int id) {this.id = id;}
	public void setName(String name) {this.name = name;}
	public void setDim(String dimension) {this.dimension = dimension;}
	public void setFormat(String format) {this.format = format;}
	public void setUrl(String url) {this.url = url;}
	public void setCol(String collocation) {this.collocation = collocation;}
	public void setDisk(Disk disk) {this.disk = disk;}
	
	public int getId() {return id;}
	public String getName() {return name;}
	public String getDim() {return dimension;}
	public String getFormat() {return format;}
	public String getUrl() {return url;}
	public String getCol() {return collocation;}
	public Disk getDisk() {return disk;}
	
}
