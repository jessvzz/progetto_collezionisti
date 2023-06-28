package it.univaq.disim.collectors.controller;

public interface DataInitializable<T>{
	default public void initializeData(T obj) {
	}

}
