package it.univaq.disim.collectors.business.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collection.Flag;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;



public class Query_JDBC {
	private Connection connection;
	private boolean supports_procedures;
	private boolean supports_function_calls;
	
	public Query_JDBC(Connection c) throws DatabaseConnectionException {
		connect(c);
	}
	
	public final void connect(Connection c) throws DatabaseConnectionException {
		this.connection = c;
		// verifichiamo quali comandi supporta il DBMS corrente
		supports_procedures = false;
		supports_function_calls = false;
		try {
			supports_procedures = connection.getMetaData().supportsStoredProcedures();
			supports_function_calls = supports_procedures
					&& connection.getMetaData().supportsStoredFunctionsUsingCallSyntax();
		} catch (SQLException ex) {
			Logger.getLogger(Query_JDBC.class.getName()).log(Level.SEVERE, null, ex);
		}
	}
	
	public Connection getConnection() {
		return this.connection;
	}
	
	public Collector login(String nickname, String email) throws DatabaseConnectionException {
		try (PreparedStatement s = connection
				.prepareStatement("select * from collezionista where nickname = ? and email = ?");) {
			s.setString(1, nickname);
			s.setString(2, email);
			try (ResultSet rs = s.executeQuery()) {
				if (rs.next())
					return new Collector(rs.getInt("id"), rs.getString("nickname"), rs.getString("email"));
			}
			return null;
		} catch (SQLException e) {
			throw new DatabaseConnectionException(e);
		}
	}
	
	public List<Collection> collectionsOwned(Collector collector) throws DatabaseConnectionException{
		List<Collection> collections = new ArrayList<>();
		
		try (PreparedStatement s = connection
				.prepareStatement("select * from collezione where ID_collezionista = ?");) {
			s.setInt(1, collector.getId());
			try (ResultSet rs = s.executeQuery()) {
				while (rs.next()) {
					
					String flagValue = rs.getString("stato");
					Flag flag = Flag.valueOf(flagValue);
					collections.add(new Collection(rs.getInt("ID"), rs.getString("nome"), flag,
							rs.getInt("ID_collezionista")));
				}
			}
			return collections;
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Login fallito", e);
		}
		
	}


}
