package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.domain.Couple;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;

public class ShareController implements Initializable, DataInitializable<Couple<Collection, Collector>>{
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collector collector;
	private Collection collection;
	private ObservableList<Collection> collectionsData;
	
	@FXML
	private ComboBox<String> userComboBox;
	
	@FXML
	private Label errorLabel;
	
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		try {
			List<Collector> collector = implementation.getAllCollectors();
			for(Collector e : collector) {
				userComboBox.getItems().add(e.getNick());
			}
			
		} catch (DatabaseConnectionException e) {
		
		} 
		
		
	}
	
	public void initializeData(Couple<Collection, Collector> couple) {
		this.collection = couple.getFirst();
		this.collector = couple.getSecond();
		
		
		
	}
	
	@FXML
	public void saveAction() {
		try {
			int idcoll = implementation.findCollectorByName(userComboBox.getValue());
			boolean p = implementation.isVisible(collection.getId(), idcoll);
			if (p == true) {
				errorLabel.setText("This user can already see this collection");
				return;
			}
			implementation.addSharing(collection.getId(), idcoll);
		} catch (DatabaseConnectionException e) {
			errorLabel.setText("This user can already see this collection");
			e.printStackTrace();
		}
		dispatcher.renderView("collections", collector);
	}
	
	@FXML
	public void cancelAction() {
		dispatcher.renderView("collections", collector);
	}

}
