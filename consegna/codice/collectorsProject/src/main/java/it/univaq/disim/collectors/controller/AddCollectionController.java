package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collection.Flag;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.domain.Disk.State;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.beans.binding.Bindings;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;

public class AddCollectionController implements Initializable, DataInitializable<Collector>{
	
	@FXML
	private TextField nameField;
	
	@FXML
	private ComboBox<Flag> stateComboBox;
	
	@FXML
	private Button saveButton, cancelButton;
	
	
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collection collection;
	private Collector collector;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		stateComboBox.getItems().addAll(Flag.values());
		saveButton.disableProperty()
		.bind(nameField.textProperty().isEmpty().or(Bindings.isNull(stateComboBox.valueProperty())));
	}
	
	public void initializeData(Collector collector) {
		this.collector = collector;
	}
	@FXML
	private void saveAction() {
		try {
			implementation.addCollection(collector, nameField.getText(), stateComboBox.getValue());
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dispatcher.renderView("collections", collector);
	}
	
	@FXML
	private void cancelAction() {
		dispatcher.renderView("collections", collector);
	}


}
