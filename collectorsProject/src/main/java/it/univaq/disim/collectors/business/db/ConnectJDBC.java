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

	// creiamo e restituiamo una singola connessione locale (singleton)
	// (che potrà essere chiusa da questo modulo)
	public Connection getConnection() throws DatabaseConnectionException {
		if (connection == null) {
			connection = connect();
		}
		return connection;
	}

	// questo metodo restituisce una nuova connessione a ogni chiamata
	// (che andrà chiusa dal ricevente!)
	public Connection newConnection() throws DatabaseConnectionException {
		return connect();
	}

	// connessione al database
	private Connection connect() throws DatabaseConnectionException {
		System.out.println("Tentativo di connessione al DB...");
		try {
			// connessione al database
			if (username != null && password != null) {
				this.connection = DriverManager.getConnection(connection_string, username, password);
			} else {
				this.connection = DriverManager.getConnection(connection_string);
			}
			System.out.println("Connessione stabilita con successo.");
			return this.connection;
		} catch (SQLException ex) {
			System.err.println("\nTentativo di connessione fallito!");
			throw new DatabaseConnectionException("Errore di connessione", ex);
		}
	}

	// disconnessione della connessione locale (singleton) se presente
	public void disconnect() throws DatabaseConnectionException {
		try {
			if (this.connection != null && !this.connection.isClosed()) {
				System.out.println("\nTentativo di disconnessione della connessione...");
				this.connection.close();
			}
		} catch (SQLException ex) {
			System.err.println("\nTentativo di disconnessione falllito");
			throw new DatabaseConnectionException("Errore di disconnessione", ex);
		}
	}

}
