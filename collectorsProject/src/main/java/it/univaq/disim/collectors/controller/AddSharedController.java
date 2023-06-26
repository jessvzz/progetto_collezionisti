package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

import org.controlsfx.control.SearchableComboBox;

import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.domain.Artist;
import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.domain.Couple;
import it.univaq.disim.collectors.domain.Etichetta;
import it.univaq.disim.collectors.domain.Format;
import it.univaq.disim.collectors.domain.Genre;
import it.univaq.disim.collectors.domain.Collection.Flag;
import it.univaq.disim.collectors.domain.Disk.State;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;
import javafx.scene.layout.VBox;

public class AddSharedController implements Initializable, DataInitializable<Collector>{
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collector collector;
	
	@FXML
	private TextField collectionComboBox;
	
	@FXML
	private Button saveButton, cancelButton;
	
	@FXML
	private ComboBox<String> userComboBox;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		try {
			/*List<Collection> collections = implementation.collectionsOwned(collector);
			for(Collection c: collections) {
				collectionComboBox.getItems().add(c.getName());
			}*/
			
			List<Collector> collector = implementation.getAllCollectors();
			for(Collector e : collector) {
				userComboBox.getItems().add(e.getNick());
			}
			
		} catch (DatabaseConnectionException e) {
		
		} 
		
		
	}
	
	public void initializeData(Collector coll) {
		this.collector = coll;
		//System.out.println(collector.getId());
	}
	@FXML
	public void saveAction () {
		try {
			int collection = implementation.findCollectionByName(collectionComboBox.getText());
			int collector = implementation.findCollectorByName(userComboBox.getValue());
			implementation.addSharing(collection, collector);
			
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dispatcher.renderView("mysharedcollections", collector);
	}
	
	@FXML
	public void cancelAction() {
		dispatcher.renderView("mysharedcollections", collector);
	}
}
