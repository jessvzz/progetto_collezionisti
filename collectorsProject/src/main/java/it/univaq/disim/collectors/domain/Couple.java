package it.univaq.disim.collectors.domain;

public class Couple<T, K> {
	
	private T t;
	private K k;
	
	public Couple(T t, K k) {
		this.t = t;
		this.k = k;
	}
	
	public T getFirst() { return t;}
	
	public K getSecond() {return k;}
}