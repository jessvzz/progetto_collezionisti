package it.univaq.disim.collectors.business.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.univaq.disim.collectors.domain.Artist;
import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collection.Flag;
import it.univaq.disim.collectors.domain.Track;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.domain.Disk;
import it.univaq.disim.collectors.domain.Disk.State;
import it.univaq.disim.collectors.domain.Etichetta;
import it.univaq.disim.collectors.domain.Genre;
import it.univaq.disim.collectors.domain.Type;
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
	
	public Etichetta findLabelById(int id) throws DatabaseConnectionException{
		Etichetta label = null;
		try(PreparedStatement s = connection
				.prepareStatement("select * "+"from etichetta "+"where ID=?;");){
			s.setInt(1, id);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					// System.out.println(id + rs.getString("p_iva"));
					label = new Etichetta(id,rs.getString("p_iva"), rs.getString("nome"));
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Etichetta non esistente");
		} return label;
	}
	
	public Artist findArtistById(int id) throws DatabaseConnectionException{
		Artist artist = null;
		try(PreparedStatement s = connection
				.prepareStatement("select * from artista where ID=?;");){
			s.setInt(1, id);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					artist = new Artist(id, rs.getString("nome_dArte"));
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Etichetta non esistente");
		} return artist;
	}
	
	public Genre findGenreById(int id) throws DatabaseConnectionException{
		Genre genre = null;
		try(PreparedStatement s = connection
				.prepareStatement("select * from genere where ID=?;");){
			s.setInt(1, id);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					genre = new Genre(id, rs.getString("nome"));
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Etichetta non esistente");
		} return genre;
	}
	
	public Type findTypeById(int id) throws DatabaseConnectionException{
		Type type = null;
		try(PreparedStatement s = connection
				.prepareStatement("select * from tipo where ID=?;");){
			s.setInt(1, id);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					type = new Type(id, rs.getString("nome"));
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Etichetta non esistente");
		} return type;
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
/* ----------- *          
 *   QUERIES   *
 * ----------- *
 */
	

	//Query 6
	public ArrayList<Disk> getDisksInCollection(Integer idCollection) throws DatabaseConnectionException {
	
		try (CallableStatement query = connection.prepareCall("{call lista_dischi(?)}");) {
			query.setInt(1, idCollection);
			ResultSet result = query.executeQuery();
			ArrayList<Disk> disks = new ArrayList<Disk>();
			while (result.next()) {
				String stateValue = result.getString("stato_di_conservazione");
				State state = State.valueOf(stateValue);
				Disk disk = new Disk(result.getInt("ID"), result.getString("titolo"),
						result.getInt("anno_uscita"), result.getInt("ID_artista"),
						result.getInt("ID_etichetta"), result.getInt("ID_collezionista"), result.getInt("ID_genere"), result.getString("barcode"), state);
				disks.add(disk);
			}
			return disks;
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Selezione Dei dischi Fallita", e);
		}
	}
	
	//Query 7
	public List<Track> getTracksByDisk(Integer id) throws DatabaseConnectionException {
		List<Track> tracks = new ArrayList<Track>();
		try (CallableStatement query = connection.prepareCall("{call tracklist(?)}");) {
			query.setInt(1, id);
			ResultSet result = query.executeQuery();

			while (result.next()) {
				Track track = new Track(result.getInt("ID"), result.getString("ISRC"), null,
						result.getString("titolo"), id);
				tracks.add(track);
			}

		} catch (SQLException e) {
			throw new DatabaseConnectionException("Inserimento fallito", e);
	}

	return tracks;
		
	}
	

}
