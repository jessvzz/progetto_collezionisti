package it.univaq.disim.collectors.controller;
import java.net.URL;
import java.time.LocalDate;
import java.util.List;
import java.util.ResourceBundle;

import org.controlsfx.control.SearchableComboBox;
import org.controlsfx.control.textfield.TextFields;

import it.univaq.disim.collectors.domain.*;
import it.univaq.disim.collectors.domain.Collection.Flag;
import it.univaq.disim.collectors.domain.Disk.State;
import it.univaq.disim.collectors.view.ViewDispatcher;
import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.controller.DataInitializable;
import javafx.beans.binding.Bindings;
import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;
import javafx.scene.layout.VBox;


public class AddDiskController implements Initializable, DataInitializable<Couple<Collection, Collector>> {
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collection collection;
	private Collector collector;
	
	@FXML
	private TextField titleTextField, yearTextField, barcodeTextField;
	
	@FXML
	private ComboBox<String> genreComboBox;
	
	@FXML
	private ComboBox<State> stateComboBox;
	
	@FXML
	private ComboBox<String> formatComboBox;
	
	@FXML
	private VBox vBox;
	
	/*@FXML
	private ComboBox<String> labelComboBox;
	
	 @FXML
	private TextField artistSearchTextField;
	 
	 @FXML
	private TextField labelSearchTextField;
	*/
	@FXML
	private SearchableComboBox<String> artistComboBox, labelComboBox;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		stateComboBox.getItems().addAll(State.values());
		try {
			List<Genre> genre = implementation.getAllGenre();
			for(Genre g : genre) {
				genreComboBox.getItems().add(g.getName());
			}
			List<Format> formats = implementation.getAllFormats();
			for(Format f : formats) {
				formatComboBox.getItems().add(f.getName());
			}
			List<Artist> artists = implementation.getAllArtists();
			for(Artist a : artists) {
				artistComboBox.getItems().add(a.getStagename());
			}
			List<Etichetta> labels = implementation.getAllLabels();
			for(Etichetta e : labels) {
				labelComboBox.getItems().add(e.getName());
			}
			
		} catch (DatabaseConnectionException e) {
		
		} 
		
		
	}
	
	public void initializeData(Couple<Collection, Collector> couple) {
		this.collection = couple.getFirst();
		this.collector = couple.getSecond();
		
		
		
	}
	
	@FXML
	public void saveAction () {
		try {
			int artista = implementation.findArtistByName(artistComboBox.getValue()); 
			int etichetta = implementation.findLabelByName(labelComboBox.getValue());
			int genere = implementation.findGenreByName(genreComboBox.getValue());
			int formato = implementation.findFormatByName(formatComboBox.getValue());
			implementation.addDisk(barcodeTextField.getText(), stateComboBox.getValue(), titleTextField.getText(), artista, etichetta, collector, collection, genere, formato, Integer.parseInt(yearTextField.getText()));
		} catch (DatabaseConnectionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dispatcher.renderView("collection", new Couple<Collection, Collector>(collection, collector));
	}
	
	@FXML
	public void cancelAction() {
		dispatcher.renderView("collection", new Couple<Collection, Collector>(collection, collector));
	}
}
