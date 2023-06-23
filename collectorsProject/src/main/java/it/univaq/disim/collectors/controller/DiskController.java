package it.univaq.disim.collectors.controller;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

import java.net.URL;
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
	private Button editButton;
	@FXML
	private Button addButton;
	@FXML 
	private TableView<Track> trackTableView;
	@FXML
	private TableColumn<Track, String> titleColumn, isrcColumn;
	@FXML
	private TableColumn<Track, Float> timeColumn;
	
	
	

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		titleColumn.setCellValueFactory(new PropertyValueFactory<Track, String>("title"));
		isrcColumn.setCellValueFactory(new PropertyValueFactory<Track, String>("isrc"));
		timeColumn.setCellValueFactory(new PropertyValueFactory<Track, Float>("time"));
	}

	
	public void initializeData(Triple<Collector, Collection, Disk> obj) {
		
		this.collector = obj.getFirst();
		this.collection = obj.getSecond();
		this.disk = obj.getThird();
		try {
			Etichetta etichetta = implementation.findLabelById(disk.getLabel());
			label.setText(disk.getTitle());
			labelLabel.setText(etichetta.getName());
			yearLabel.setText(Integer.toString(disk.getYear()));
			artistLabel.setText(implementation.findArtistById(disk.getArtist()).getStagename());
		
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
