package it.univaq.disim.collectors.domain;

public class Copy {
	private int id;
	private Flag status;
	private String barcode;
	private Disk disk;
	private Type type;
	private Collection collection;
	
	public enum Flag{
		OTTIMO, BUONO, USURATO;
	}
	
	public Copy(int id, Flag status, String barcode, Disk disk, Type type, Collection collection) {
		this.id = id;
		this.status = status;
		this.barcode = barcode;
		this.disk = disk;
		this.type = type;
		this.collection = collection;
	}
	
	public void setId(int id) {this.id=id;}
	public void setStatus(Flag status) {this.status=status;}
	public void setBarcode(String barcode) {this.barcode=barcode;}
	public void setDisk(Disk disk) {this.disk = disk;}
	public void setType(Type type) {this.type = type;}
	public void setCollection(Collection collection) {this.collection = collection;}
	
	public int getID() {return id;}
	public Flag getStatus() {return status;}
	public String getBarcode() {return barcode;}
	public Disk getDisk() {return disk;}
	public Type getType() {return type;}
	public Collection getCollection() {return collection;}

}
