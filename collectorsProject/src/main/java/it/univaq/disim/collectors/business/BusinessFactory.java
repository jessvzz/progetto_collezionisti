package it.univaq.disim.collectors.business;

import it.univaq.disim.collectors.business.db.DBImplementation;
import it.univaq.disim.collectors.business.db.Query_JDBC;

public class BusinessFactory {
private static DBImplementation	implementation = new DBImplementation();
	
	public static Query_JDBC getImplementation(){
		return implementation.getImplementation();
	}

}
