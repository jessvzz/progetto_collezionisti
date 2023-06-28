package it.univaq.disim.collectors.business.db;

public class DatabaseConnectionException extends Exception {
	public DatabaseConnectionException() {
		super();
	}

	public DatabaseConnectionException(Exception e) {
		super(e);
	}

	public DatabaseConnectionException(String cause, Exception e) {
		super(cause, e);
	}
	public DatabaseConnectionException(String cause) {
		super(cause);
	}

}
