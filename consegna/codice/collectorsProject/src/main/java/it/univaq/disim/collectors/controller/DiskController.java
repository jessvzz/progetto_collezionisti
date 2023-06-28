package it.univaq.disim.collectors.controller;

import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.domain.Disk;
import it.univaq.disim.collectors.domain.Etichetta;
import it.univaq.disim.collectors.domain.Triple;
import it.univaq.disim.collectors.domain.Track;
import it.univaq.disim.collectors.view.ViewDispatcher;


public class DiskController implements Initializable, DataInitializable<Triple<Collector, Collection, Disk>>{
	
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();
	
	private Collector collector;
	private Collection collection;
	private Disk disk;
	
	
	@FXML
	private Label label, genreLabel, yearLabel, artistLabel, stateLabel, formatLabel, barcodeLabel, labelLabel;
	
	
	@FXML
	private Button addButton;
	@FXML 
	private TableView<Track> trackTableView;
	@FXML
	private TableColumn<Track, String> titleColumn, ISRCColumn;
	@FXML
	private TableColumn<Track, Float> TimeColumn;
	
	
	

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		titleColumn.setCellValueFactory(new PropertyValueFactory<Track, String>("title"));
		ISRCColumn.setCellValueFactory(new PropertyValueFactory<Track, String>("ISRC"));
		TimeColumn.setCellValueFactory(new PropertyValueFactory<Track, Float>("time"));
		
	}

	
	public void initializeData(Triple<Collector, Collection, Disk> obj) {
		
		this.collector = obj.getFirst();
		this.collection = obj.getSecond();
		this.disk = obj.getThird();
		if(this.disk.getCollector()!= collector.getId()) {
			addButton.setVisible(false);
		}
		
		
		try {
			Etichetta etichetta = implementation.findLabelById(disk.getLabel());
			label.setText(disk.getTitolo());
			labelLabel.setText("Label: "+ etichetta.getName());
			yearLabel.setText("Year: " + Integer.toString(disk.getYear()));
			artistLabel.setText("Artist: "+implementation.findArtistById(disk.getArtist()).getStagename());
			genreLabel.setText("Genre: "+implementation.findGenreById(disk.getGenre()).getName());
			formatLabel.setText("Format: "+implementation.findTypeById(disk.getFormat()).getName());
			barcodeLabel.setText("Barcode: "+ disk.getBarcode());
			stateLabel.setText("State: "+disk.getState().toString());
			List<Track> tracks = implementation.getTracksByDisk(disk.getId());
			trackTableView.setItems(FXCollections.observableArrayList(tracks));
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	
	
	public void addAction() {
		dispatcher.renderView("addTracks", new Triple<Collection, Collector, Disk>(collection, collector, disk));
	}
	
}
