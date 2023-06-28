package it.univaq.disim.collectors.business;

import it.univaq.disim.collectors.business.db.JDBC_mySQL;
import it.univaq.disim.collectors.business.db.Query_JDBC;

public class BusinessFactory {
private static JDBC_mySQL	implementation = new JDBC_mySQL();
	
	public static Query_JDBC getImplementation(){
		return implementation.getImplementation();
	}

}
