package it.univaq.disim.collectors.business.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class ConnectJDBC {
	private Connection connection;
	private final String password;
	private final String username;
	private final String connection_string;

	public ConnectJDBC(String connection_string, String username, String password) {
		this.password = password;
		this.username = username;
		this.connection_string = connection_string;
		this.connection = null;
	}

	public Connection getConnection() throws DatabaseConnectionException {
		if (connection == null) {
			connection = connect();
		}
		return connection;
	}

	
	public Connection newConnection() throws DatabaseConnectionException {
		return connect();
	}


	private Connection connect() throws DatabaseConnectionException {
		try {
		
			if (username != null && password != null) {
				this.connection = DriverManager.getConnection(connection_string, username, password);
			} else {
				this.connection = DriverManager.getConnection(connection_string);
			}
			System.out.println("Now Connected to DB");
			return this.connection;
		} catch (SQLException ex) {
			System.err.println("\n Unable to connect");
			throw new DatabaseConnectionException("Connection error", ex);
		}
	}
	
	
	


	
	public void disconnect() throws DatabaseConnectionException {
		try {
			if (this.connection != null && !this.connection.isClosed()) {
				System.out.println("\nDisconnecting...");
				this.connection.close();
			}
		} catch (SQLException ex) {
			throw new DatabaseConnectionException("\nUnable to disconnect", ex);
		}
	}

}
