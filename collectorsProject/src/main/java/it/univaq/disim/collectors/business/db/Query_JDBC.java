package it.univaq.disim.collectors.business.db;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import it.univaq.disim.collectors.domain.Appartiene;
import it.univaq.disim.collectors.domain.Artist;
import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collection.Flag;
import it.univaq.disim.collectors.domain.Track;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.domain.Disk;
import it.univaq.disim.collectors.domain.Disk.State;
import it.univaq.disim.collectors.domain.Etichetta;
import it.univaq.disim.collectors.domain.Genre;
import it.univaq.disim.collectors.domain.Format;
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
		/*supports_procedures = false;
		supports_function_calls = false;
		try {
			supports_procedures = connection.getMetaData().supportsStoredProcedures();
			supports_function_calls = supports_procedures
					&& connection.getMetaData().supportsStoredFunctionsUsingCallSyntax();
		} catch (SQLException ex) {
			Logger.getLogger(Query_JDBC.class.getName()).log(Level.SEVERE, null, ex);
		}*/
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
					return new Collector(rs.getInt("id"), rs.getString("nickname"), rs.getString("email"), rs.getString("nome"));
			}
			return null;
		} catch (SQLException e) {
			throw new DatabaseConnectionException(e);
		}
	}
	
	public void signUp(String nickname, String email, String name, String last) throws DatabaseConnectionException {
		String signUpQuery = "INSERT INTO collezionista (nickname, email, nome, cognome) " +
                "VALUES (?, ?, ?, ?)";
		try (PreparedStatement s = connection
				.prepareStatement(signUpQuery);) {
			s.setString(1, nickname);
			s.setString(2, email);
			s.setString(3, name);
			s.setString(3, last);
			s.executeUpdate();
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
			throw new DatabaseConnectionException("Label not found");
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
			throw new DatabaseConnectionException("Artist not found");
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
			throw new DatabaseConnectionException("Genre not found");
		} return genre;
	}
	
	public Format findTypeById(int id) throws DatabaseConnectionException{
		Format type = null;
		try(PreparedStatement s = connection
				.prepareStatement("select * from tipo where ID=?;");){
			s.setInt(1, id);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					type = new Format(id, rs.getString("nome"));
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Type not found");
		} return type;
	}
	
	public int findFormatByName(String name) throws DatabaseConnectionException {
		int id = 0;
		try(PreparedStatement s = connection
				.prepareStatement("select * from tipo where nome = ?;");){
			s.setString(1, name);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					id = rs.getInt("ID");
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Type not found");
		} return id;
	}
	
	public int findGenreByName(String name) throws DatabaseConnectionException {
		int id = 0;
		try(PreparedStatement s = connection
				.prepareStatement("select * from genere where nome = ?;");){
			s.setString(1, name);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					id = rs.getInt("ID");
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Genre not found");
		} return id;
	}
	
	public int findArtistByName(String name) throws DatabaseConnectionException {
		int id = 0;
		try(PreparedStatement s = connection
				.prepareStatement("select * from artista where nome_dArte = ?;");){
			s.setString(1, name);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					id = rs.getInt("ID");
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Artist not found");
		} return id;
	}
	
	public int findLabelByName(String name) throws DatabaseConnectionException {
		int id = 0;
		try(PreparedStatement s = connection
				.prepareStatement("select * from etichetta where nome = ?;");){
			s.setString(1, name);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					id = rs.getInt("ID");
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Label not found");
		} return id;
	}
	
	public int findCollectorByName(String name) throws DatabaseConnectionException {
		int id = 0;
		try(PreparedStatement s = connection
				.prepareStatement("select * from collezionista where nickname = ?;");){
			s.setString(1, name);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					id = rs.getInt("ID");
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Etichetta non esistente");
		} return id;
	}
	
	public int findCollectionByName(String name) throws DatabaseConnectionException {
		int id = 0;
		try(PreparedStatement s = connection
				.prepareStatement("select * from collezione where nome = ?;");){
			s.setString(1, name);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					id = rs.getInt("ID");
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Etichetta non esistente");
		} return id;
	}
	
	public int findDiskByName(String name) throws DatabaseConnectionException {
		int id = 0;
		try(PreparedStatement s = connection
				.prepareStatement("select * from disco where titolo = ?;");){
			s.setString(1, name);
			try(ResultSet rs = s.executeQuery()){
				while(rs.next()) {
					id = rs.getInt("ID");
							
				}
			} 
		} catch (SQLException e1) {
			throw new DatabaseConnectionException("Etichetta non esistente");
		} return id;
	}

	public List<Collector> getAllCollectors() throws DatabaseConnectionException {

		List<Collector> collectors = new ArrayList<>();

		try (PreparedStatement s = connection.prepareStatement("select * from collezionista;")) {
			try (ResultSet rs = s.executeQuery()) {
				while (rs.next()) {
					collectors.add(new Collector(rs.getInt("ID"), rs.getString("nickname"), rs.getString("email"), rs.getString("nome")));
				}
			}
			return collectors;
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Unable to find collectors", e);
		}
	}
	
	
	public List<Artist> getAllArtists() throws DatabaseConnectionException {

		List<Artist> artists = new ArrayList<>();

		try (PreparedStatement s = connection.prepareStatement("select * from artista;")) {
			try (ResultSet rs = s.executeQuery()) {
				while (rs.next()) {
					artists.add(new Artist(rs.getInt("ID"), rs.getString("nome_dArte")));
				}
			}
			return artists;
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Artist not found", e);
		}
	}
	
	public List<Etichetta> getAllLabels() throws DatabaseConnectionException {

		List<Etichetta> labels = new ArrayList<>();

		try (PreparedStatement s = connection.prepareStatement("select * from etichetta;")) {
			try (ResultSet rs = s.executeQuery()) {
				while (rs.next()) {
					labels.add(new Etichetta(rs.getInt("ID"), rs.getString("p_iva"), rs.getString("nome")));
				}
			}
			return labels;
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Label not found", e);
		}
	}
	
	
	public List<Format> getAllFormats() throws DatabaseConnectionException {

		List<Format> formats = new ArrayList<>();

		try (PreparedStatement s = connection.prepareStatement("select * from tipo;")) {
			try (ResultSet rs = s.executeQuery()) {
				while (rs.next()) {
					formats.add(new Format(rs.getInt("ID"), rs.getString("nome")));
				}
			}
			return formats;
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Type not found", e);
		}
	}
	
	public List<Genre> getAllGenre() throws DatabaseConnectionException {

		List<Genre> genre = new ArrayList<>();

		try (PreparedStatement s = connection.prepareStatement("select * from genere;")) {
			try (ResultSet rs = s.executeQuery()) {
				while (rs.next()) {
					genre.add(new Genre(rs.getInt("ID"), rs.getString("nome")));
				}
			}
			return genre;
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Genre not found", e);
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
			throw new DatabaseConnectionException("Collector not found", e);
		}
		
	}
	

	
	public List<Collection> collectionsShared(Collector collector) throws DatabaseConnectionException{
		List<Collection> collections = new ArrayList<>();
		
		String sql = "SELECT con.ID_collezione, coll.nome, coll.stato, coll.ID_collezionista FROM condivisa con " +
             "JOIN collezione coll ON (coll.ID = con.ID_collezione) " +
             "WHERE ? = con.ID_collezionista";

try (PreparedStatement query = connection.prepareStatement(sql)) {
    query.setInt(1, collector.getId());
			try (ResultSet rs = query.executeQuery()) {
				while (rs.next()) {
					
					String flagValue = rs.getString("stato");
					Flag flag = Flag.valueOf(flagValue);
					collections.add(new Collection(rs.getInt("ID_collezione"), rs.getString("nome"), flag,
							rs.getInt("ID_collezionista")));
				}
			}
			return collections;
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Unable to find a collection shared with you", e);
		}
		
	}
	

	
	/*public void addExistingDisk(Disk disk, Collection collection) throws DatabaseConnectionException {
		int ID_disk = disk.getId();
		int ID_coll = collection.getId();
		try (PreparedStatement s = connection.prepareStatement("SELECT * FROM disco d "
				+ "WHERE d.ID = ?; "
				+ "INSERT INTO disco d VALUES (ID, d.barcode, d.stato_di_conservazione, d.titolo, d.ID_artista, d.ID_collezionista, ?, d.ID_genere, d.ID_tipo, d.anno_uscita);")) {
			s.setInt(1, ID_disk);
			s.setInt(2, ID_coll);
			s.executeQuery();
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Unable to find collections shared with you", e);
		}
	}*/
	
	public void addExistingDisk(Disk disk, Collection collection) throws DatabaseConnectionException {
	    int existingDiskID = disk.getId();
	    int newCollectionID = collection.getId();
	    
	    try {
	        // Seleziona il disco esistente dalla tabella disco
	        String selectDiskQuery = "SELECT * FROM disco WHERE ID = ?";
	        PreparedStatement selectDiskStatement = connection.prepareStatement(selectDiskQuery);
	        selectDiskStatement.setInt(1, existingDiskID);
	        ResultSet resultSet = selectDiskStatement.executeQuery();
	        
	        if (resultSet.next()) {
	            // Recupera i valori del disco esistente
	            String barcode = resultSet.getString("barcode");
	            String statoDiConservazione = resultSet.getString("stato_di_conservazione");
	            String titolo = resultSet.getString("titolo");
	            int artistID = resultSet.getInt("ID_artista");
	            int etichettaID = resultSet.getInt("ID_etichetta");
	            int collezionistaID = resultSet.getInt("ID_collezionista");
	            int genereID = resultSet.getInt("ID_genere");
	            int tipoID = resultSet.getInt("ID_tipo");
	            int annoUscita = resultSet.getInt("anno_uscita");
	            
	          
	            
	            // Inserisci un nuovo disco duplicato nella tabella disco
	            String insertDiskQuery = "INSERT INTO disco (barcode, stato_di_conservazione, titolo, ID_artista, ID_etichetta, ID_collezionista, ID_collezione, ID_genere, ID_tipo, anno_uscita) " +
	                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	            PreparedStatement insertDiskStatement = connection.prepareStatement(insertDiskQuery);
	            
	            insertDiskStatement.setString(1, barcode);
	            insertDiskStatement.setString(2, statoDiConservazione);
	            insertDiskStatement.setString(3, titolo);
	            insertDiskStatement.setInt(4, artistID);
	            insertDiskStatement.setInt(5, etichettaID);
	            insertDiskStatement.setInt(6, collezionistaID);
	            insertDiskStatement.setInt(7, newCollectionID);
	            insertDiskStatement.setInt(8, genereID);
	            insertDiskStatement.setInt(9, tipoID);
	            insertDiskStatement.setInt(10, annoUscita);
	            
	            insertDiskStatement.executeUpdate();
	        } else {
	            throw new DatabaseConnectionException("Unable to find the existing disk with ID: " + existingDiskID);
	        }
	    } catch (SQLException e) {
	        throw new DatabaseConnectionException("Unable to duplicate the existing disk", e);
	    }
	}


	
	public void addArtist(String name, boolean group) throws DatabaseConnectionException {
		try (PreparedStatement s = connection.prepareStatement("INSERT INTO artista VALUES (ID,?,?,?,?);")) {
			s.setString(1, name);
			s.setString(2, name);
			s.setString(3, name);
			s.setBoolean(4, group);
			s.executeUpdate();
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Unable to add this artist", e);
		}
	}
	
	public void addlabel(String name, String p_iva) throws DatabaseConnectionException {
		try (PreparedStatement s = connection.prepareStatement("INSERT INTO etichetta VALUES (ID,?,?);")) {
			s.setString(1, p_iva);
			s.setString(2, name);
			s.executeUpdate();
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Unable to add this label", e);
		}
	}
	
	
	
/* ----------- *          
 *   QUERIES   *
 * ----------- *
 */
	
	//Query 1
	public void addCollection(Collector collector, String name, Flag state) throws DatabaseConnectionException {
		try (CallableStatement query = connection.prepareCall("{call inserimento_collezione(?,?,?)}");) {
			query.setInt(1, collector.getId());
			query.setString(2, name);
			query.setString(3, state.toString());;
			query.execute();
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Unable to add collection", e);
		}
	}
	
	//Query 2.1
	public void addDisk(String barcode, State state, String title, int artist, int label, Collector collector, Collection collection, int genre, int format, int year) throws DatabaseConnectionException {
		try (CallableStatement query = connection.prepareCall("{call inserimento_disco(?,?,?, ?, ?, ?, ? , ?, ?, ?)}");) {
			query.setString(1, barcode);
			query.setString(2, state.toString());
			query.setString(3, title);
			query.setInt(4, artist);
			query.setInt(5, label);
			query.setInt(6, collector.getId());
			query.setInt(7, collection.getId());
			query.setInt(8, genre);
			query.setInt(9, format);
			query.setInt(10, year);;
			query.execute();
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Unable to add collection", e);
		}
	}
	
	//Query 2.2
	public void addTrack(String isrc, String time, String title, Disk disk, Appartiene flag, int artist ) throws DatabaseConnectionException {
		try (CallableStatement query = connection.prepareCall("{call inserimento_traccia(?,?,?, ?, ?, ?)}");) {
			query.setString(1, isrc);
			query.setString(2, time);
			query.setString(3, title);
			query.setInt(4, disk.getId());
			query.setString(5, flag.toString());
			query.setInt(6, artist);
			query.execute();
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Unable to add collection", e);
		}
		
	}
	
	//Query 3a
		public void editStatus(int idcollezione) throws DatabaseConnectionException {
			try (CallableStatement query = connection.prepareCall("{call modifica_pubblicazione(?)}");) {
				query.setInt(1, idcollezione);
				
				query.execute();
			} catch (SQLException e) {
				throw new DatabaseConnectionException("Unable to change status", e);
			}
			
		}

	
	//Query 3b
	public void addSharing(int idcollezione, int iduser) throws DatabaseConnectionException {
		try (CallableStatement query = connection.prepareCall("{call inserimento_condivisioni(?,?)}");) {
			query.setInt(1, idcollezione);
			query.setInt(2, iduser);
			
			query.execute();
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Unable to add collection", e);
		}
		
	}
	//Query4
		public void deleteDisk(int idisco) throws DatabaseConnectionException {
			try (CallableStatement query = connection.prepareCall("{call rimozione_disco(?)}");) {
				query.setInt(1, idisco);
				
				query.execute();
			} catch (SQLException e) {
				throw new DatabaseConnectionException("Unable to remove collection", e);
			}
			
		}
	
	//Query5
	public void deleteCollection(int idcollezione) throws DatabaseConnectionException {
		try (CallableStatement query = connection.prepareCall("{call rimozione_collezione(?)}");) {
			query.setInt(1, idcollezione);
			
			query.execute();
		} catch (SQLException e) {
			throw new DatabaseConnectionException("Unable to remove collection", e);
		}
		
	}

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
						result.getInt("ID_etichetta"), result.getInt("ID_collezionista"), result.getInt("ID_genere"), result.getString("barcode"), state, result.getInt("ID_tipo"));
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
				Track track = new Track(result.getInt("ID"), result.getString("ISRC"), result.getTime("durata"),
						result.getString("titolo"), id);
				tracks.add(track);
			}

		} catch (SQLException e) {
			throw new DatabaseConnectionException("Inserimento fallito", e);
	}

	return tracks;
		
	}
	
	//Query 8
		public List<Disk> getDisksByString(String string, Collector collector, boolean mine, boolean shared, boolean pub) throws DatabaseConnectionException {
			List<Disk> disks = new ArrayList<Disk>();
			try (CallableStatement query = connection.prepareCall("{call ricerca_dischi(?, ?, ?, ?, ?)}");) {
				query.setString(1, string);
				query.setInt(2, collector.getId());
				query.setBoolean(3, mine);
				query.setBoolean(4, shared);
				query.setBoolean(5, pub);
				
				ResultSet result = query.executeQuery();

				while (result.next()) {
						String stateValue = result.getString("stato_di_conservazione");
						State state = State.valueOf(stateValue);
						Disk disk = new Disk(result.getInt("ID"), result.getString("titolo"),
								result.getInt("anno_uscita"), result.getInt("ID_artista"),
								result.getInt("ID_etichetta"), result.getInt("ID_collezionista"), result.getInt("ID_genere"), result.getString("barcode"), state, result.getInt("ID_tipo"));
						disks.add(disk);
				}

			} catch (SQLException e) {
				throw new DatabaseConnectionException("Inserimento fallito", e);
		}
					
					return disks;	
		}
		
	//Query 9
		public boolean isVisible(int collezione, int collezionista) throws DatabaseConnectionException {
		    boolean p = false;
		    try (CallableStatement query = connection.prepareCall("{call check_visibilita(?, ?)}");) {
		        query.setInt(1, collezione);
		        query.setInt(2, collezionista);
		        query.execute();
		        ResultSet result = query.getResultSet();
		        if (result.next()) {
		            p = result.getBoolean(1); // Ottieni il valore dalla colonna 1 (p)
		        }
		        result.close();
		    } catch (SQLException e) {
		        throw new DatabaseConnectionException("Unable to check visibility", e);
		    }
		    return p;
		}
		
		//Query 10
				public int countTracks(int autore) throws DatabaseConnectionException {
				    int brani = 0;
				    try (CallableStatement query = connection.prepareCall("{call conta_brani_autore(?)}");) {
				        query.setInt(1, autore);
				        query.execute();
				        ResultSet result = query.getResultSet();
				        if (result.next()) {
				            brani = result.getInt(1);
				        }
				        result.close();
				    } catch (SQLException e) {
				        throw new DatabaseConnectionException("Unable to count tracks", e);
				    }
				    return brani;
				}
		
				//Query 11
				public LocalTime countMinutes(int autore) throws DatabaseConnectionException {
				    LocalTime minuti = null;
				    try (CallableStatement query = connection.prepareCall("{call conta_minuti(?)}");) {
				        query.setInt(1, autore);
				        query.execute();
				        ResultSet result = query.getResultSet();
				        if (result.next()) {
				            Time timeValue = result.getTime("minuti_totali");
				            if (timeValue != null) {
				                minuti = timeValue.toLocalTime();
				            }
				        }
				        result.close();
				    } catch (SQLException e) {
				        throw new DatabaseConnectionException("Unable to count minutes", e);
				    }
				    return minuti;
				}


		
	//Query 13
		public List<Disk> query13(String barcode,String artist, String title, Collector collector) throws DatabaseConnectionException{
			List<Disk> disks = new ArrayList<>();
			if (barcode.equals("")) {
				try (CallableStatement s = connection.prepareCall("call trova_dischi_simili_barcode_nullo(?,?,?)");){
				s.setString(1, title);
				s.setString(2, artist);
				s.setInt(3, collector.getId());
				ResultSet result = s.executeQuery();
				while (result.next()) {
					disks.add(new Disk(result.getInt("ID"),result.getString("titolo"), 0, result.getInt("ID_artista"),0,collector.getId(),0, result.getString("barcode"),null,0));
				 
			}} catch (SQLException e) {
				throw new DatabaseConnectionException("Inserimento fallito", e);
		}}
			else {
				try (CallableStatement s = connection.prepareCall("call trova_dischi_simili_barcode(?,?)");){
					s.setString(1, barcode);
					s.setInt(2, collector.getId());
					ResultSet result = s.executeQuery();
					while (result.next()) {
						disks.add(new Disk(result.getInt("ID"),result.getString("titolo"), 0, result.getInt("ID_artista"),0,result.getInt("ID_collezionista"),0, result.getString("barcode"),null,0));
					 
				}} catch (SQLException e) {
					throw new DatabaseConnectionException("Inserimento fallito", e);
			}
			
		} return disks;} 
		
		// Funzione per contare le copie
		public int numberOfCopies(int disk) throws DatabaseConnectionException {
			int copies = 0;
				String statement = "select conta_copie(?) as 'copies';";
			try (PreparedStatement query = connection.prepareStatement(statement)) {
				query.setInt(1, disk);
				ResultSet result = query.executeQuery();
				while (result.next()) {
					copies = result.getInt("copies");
				}
			} catch (SQLException e) {
				throw new DatabaseConnectionException("Unable to count copies", e);
			}
			return copies;
		}
		
		//procedure A
		public List<Collection> mySharedCollections(Collector collector) throws DatabaseConnectionException {
		    List<Collection> collections = new ArrayList<>();
		    try (CallableStatement s = connection.prepareCall("{CALL mie_collezioni_condivise(?)}")) {
		        s.setInt(1, collector.getId());
		        boolean hasResults = s.execute();
		        if (hasResults) {
		            try (ResultSet result = s.getResultSet()) {
		                while (result.next()) {
		                    String flagValue = result.getString("stato");
		                    Flag flag = Flag.valueOf(flagValue);
		                    collections.add(new Collection(result.getInt("ID_collezione"), result.getString("nome"), flag,
		                            result.getInt("ID_collezionista")));
		                }
		            }
		        }
		    } catch (SQLException e) {
		        throw new DatabaseConnectionException("Unable to find collections shared with you", e);
		    }
		    return collections;
		}
		
		

	
}
