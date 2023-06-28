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
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.TextField;

public class LabelController implements Initializable, DataInitializable<Collector> {
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collector collector;
	 
	@FXML
	private TextField nameField, pivaField;
	
	@FXML
	private Button saveButton;
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		saveButton.disableProperty()
		.bind(nameField.textProperty().isEmpty().or(pivaField.textProperty().isEmpty()));
		
	}
	
	public void initializeData(Collector collector) {

		this.collector = collector;

	}
	
	@FXML
	public void saveAction() {
		try {
			implementation.addlabel(nameField.getText(), pivaField.getText());
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
