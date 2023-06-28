package it.univaq.disim.collectors.domain;

public class Triple <T, K, V> {

	private T t;
	private K k;
	private V v;
	
	public Triple(T t, K k, V v) {
		this.t = t;
		this.k = k;
		this.v = v;
	}
	
	public T getFirst() { return t;}
	
	public K getSecond() { return k;}
	
	public V getThird() { return v;}
}
