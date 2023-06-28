package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

import org.controlsfx.control.SearchableComboBox;

import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.domain.Appartiene;
import it.univaq.disim.collectors.domain.Artist;
import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.domain.Couple;
import it.univaq.disim.collectors.domain.Disk;
import it.univaq.disim.collectors.domain.Triple;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.beans.binding.Bindings;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.RadioButton;
import javafx.scene.control.Spinner;
import javafx.scene.control.SpinnerValueFactory;
import javafx.scene.control.TextField;
import javafx.util.converter.IntegerStringConverter;

public class AddTracksController implements Initializable, DataInitializable<Triple<Collection, Collector, Disk>>{
	
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collection collection;
	private Collector collector;
	private Disk disk;
	
	@FXML
	private TextField nameField, isrcField;
	
	@FXML
	private Spinner<Integer> hoursSpinner, minutesSpinner, secondsSpinner;
	
	@FXML
	private RadioButton esecutoreButton, compositoreButton;
	
	@FXML
	private SearchableComboBox<String> artistComboBox;
	
	@FXML
	private Button saveButton;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		saveButton.disableProperty()
		.bind(nameField.textProperty().isEmpty().or(isrcField.textProperty().isEmpty()).or(Bindings.isNull(artistComboBox.valueProperty())));
		initializeSpinner(hoursSpinner, 0, 23, 0); 
	    initializeSpinner(minutesSpinner, 0, 59, 0);
	    initializeSpinner(secondsSpinner, 0, 59, 0);
	    try{
	    	List<Artist> artists;
			artists = implementation.getAllArtists();
	
		for(Artist a : artists) {
			artistComboBox.getItems().add(a.getStagename());
		}
	} catch (DatabaseConnectionException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();}
	}
	
	
	private void initializeSpinner(Spinner<Integer> spinner, int min, int max, int defaultValue) {
	    // Imposta il factory per creare gli elementi dell'editor dello spinner
	    SpinnerValueFactory.IntegerSpinnerValueFactory valueFactory =
	            new SpinnerValueFactory.IntegerSpinnerValueFactory(min, max, defaultValue);
	    
	    // Imposta il formato dell'editor (opzionale)
	    valueFactory.setConverter(new IntegerStringConverter());
	    
	    // Imposta il factory come factory dello spinner
	    spinner.setValueFactory(valueFactory);
	}
	

	public void initializeData(Triple<Collection, Collector, Disk> thing) {
		this.collection = thing.getFirst();
		this.collector = thing.getSecond();
		this.disk = thing.getThird();
	
	}
	
	@FXML
	public void saveAction() {
		try {
			int artista = implementation.findArtistByName(artistComboBox.getValue()); 
			String durata = hoursSpinner.getValue().toString()+":"+  minutesSpinner.getValue().toString()+":"+secondsSpinner.getValue().toString();
			Appartiene flag = null;
			if(esecutoreButton.isSelected()) flag = Appartiene.ESECUTORE;
			else if(compositoreButton.isSelected()) flag = Appartiene.COMPOSITORE;
			else flag = Appartiene.ENTRAMBI;
			implementation.addTrack(isrcField.getText(), durata, nameField.getText(), disk, flag, artista);
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dispatcher.renderView("disk", new Triple<Collector, Collection, Disk>(collector, collection, disk));
	}
		
	
	@FXML
	public void cancelAction() {dispatcher.renderView("disk", new Triple<Collector, Collection, Disk>(collector, collection, disk));}

}
