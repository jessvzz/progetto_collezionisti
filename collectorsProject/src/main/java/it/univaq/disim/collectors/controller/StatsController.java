package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.time.LocalTime;
import java.util.List;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.domain.Artist;
import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.domain.Etichetta;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;

public class StatsController implements Initializable, DataInitializable<Collector> {
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();
	private Collector collector;
	
	@FXML
	private TextField diskName;
	@FXML
	private ComboBox<String> artistTracks, artistMinutes;
	@FXML
	private Button search1, search2, search3;
	@FXML
	private Label diskLabel, tracksLabel, minutesLabel;
	
	

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		try {
		List<Artist> artists = implementation.getAllArtists();
		for(Artist a : artists) {
			artistTracks.getItems().add(a.getStagename());
			artistMinutes.getItems().add(a.getStagename());
		}
		
	} catch (DatabaseConnectionException e) {
	
	} 
		
	}
	
	@Override
	public void initializeData(Collector coll) {
		this.collector = coll;
			

	}
	
	@FXML
	public void searchDisk() {
		String disk = diskName.getText();
		try {
			int diskId = implementation.findDiskByName(disk);
			int number = implementation.numberOfCopies(diskId);
			diskLabel.setText(Integer.toString(number));
		}catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@FXML
	public void searchTracks() {
		String artistName = artistTracks.getValue();
		try {
			int artistId = implementation.findArtistByName(artistName);
			int number = implementation.countTracks(artistId);
			tracksLabel.setText(Integer.toString(number));
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@FXML
	public void searchMinutes() {
	    String artistName = artistMinutes.getValue();
	    try {
	        int artistId = implementation.findArtistByName(artistName);
	        LocalTime totalMinutes = implementation.countMinutes(artistId);
	        if (totalMinutes != null) {
	            String minutesString = totalMinutes.toString();
	            minutesLabel.setText(minutesString);
	        } else {
	            // Handle the case when totalMinutes is null
	            minutesLabel.setText("0");
	        }
	    } catch (DatabaseConnectionException e) {
	        // TODO Auto-generated catch block
	        e.printStackTrace();
	    }
	}

	
	

}
