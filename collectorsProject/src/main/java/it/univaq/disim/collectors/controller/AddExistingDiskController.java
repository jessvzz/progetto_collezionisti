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
import it.univaq.disim.collectors.domain.Disk;
import it.univaq.disim.collectors.domain.Triple;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TextField;
import javafx.scene.control.TableView;
import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.collections.FXCollections;

public class AddExistingDiskController implements Initializable, DataInitializable<Couple<Collection, Collector>>{
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collection collection;
	private Collector collector;
	private ObservableList<Disk> disksList;
	
	@FXML
	private TextField barcode, artist, title;
	
	@FXML
	private Button searchButton;
	
	@FXML
	private TableView<Disk> disksTableView;
	
	@FXML
	private TableColumn<Disk, String> barcodeTableColumn, titleTableColumn, artistTableColumn;
	
	@FXML
	private TableColumn<Disk, Button> manageTableColumn;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		//searchButton.disableProperty().bind(
				//searchBar.textProperty().isEmpty());
		
		barcodeTableColumn.setCellValueFactory(new PropertyValueFactory<Disk, String>("barcode"));
		titleTableColumn.setCellValueFactory(new PropertyValueFactory<Disk, String>("titolo"));
		artistTableColumn.setCellValueFactory((CellDataFeatures<Disk, String> param) -> {
			try {
				return new SimpleStringProperty(implementation.findArtistById(param.getValue().getArtist()).getStagename());
			} catch (DatabaseConnectionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}//param.getValue().getArtist().getUsername().toString());
			return null;
		});
		manageTableColumn.setStyle("-fx-alignment: CENTER;");
		manageTableColumn.setCellValueFactory((CellDataFeatures<Disk, Button> param) -> {
			final Button viewButton = new Button("Choose");
			viewButton.setOnAction((ActionEvent event) -> {
				try {
					implementation.addExistingDisk(param.getValue(), this.collection);
				} catch (DatabaseConnectionException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			});
			return new SimpleObjectProperty<Button>(viewButton);
		});
		
	}
	
	public void InitializeData(Couple<Collection, Collector> things) {
		this.collection = things.getFirst();
		this.collector = things.getSecond();
		
}
	
	
	@FXML
	public void search() {
		System.out.println(this.collector.getId());
		String titolo = title.getText();
		if (!artist.getText().isEmpty()&& title.getText().isEmpty()) titolo = " "; 
		try {
			List<Disk> disks = implementation.query13(barcode.getText(), artist.getText(), titolo, this.collector);
			disksList = FXCollections.observableArrayList(disks);
			disksTableView.setItems((ObservableList<Disk>)disksList);
	} catch (DatabaseConnectionException e) {
		e.printStackTrace();
	}

}}
