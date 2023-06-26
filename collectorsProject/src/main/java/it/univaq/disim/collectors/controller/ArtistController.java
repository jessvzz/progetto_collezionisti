package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.CheckBox;
import javafx.scene.control.TextField;

public class ArtistController implements Initializable, DataInitializable<Collector> {
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collector collector;
	 
	@FXML
	private TextField nameField;
	
	@FXML 
	private CheckBox gruppoCheck;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
		
	}
	
	public void initializeData(Collector collector) {

		this.collector = collector;

	}
	
	@FXML
	public void saveAction() {
		boolean gruppo = gruppoCheck.isSelected();
		try {
			implementation.addArtist(nameField.getText(), gruppo);
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dispatcher.renderView("addArtist", collector);
	}
	
	@FXML
	public void cancelAction() {
		dispatcher.renderView("addArtist", collector);
	}
}
