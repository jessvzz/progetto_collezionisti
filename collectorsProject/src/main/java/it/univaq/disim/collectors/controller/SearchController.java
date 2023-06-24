package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.time.LocalDate;
import java.util.List;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.domain.Disk;
import it.univaq.disim.collectors.domain.Triple;
import it.univaq.disim.collectors.view.ViewDispatcher;	
import javafx.beans.property.SimpleObjectProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.scene.control.cell.PropertyValueFactory;

public class SearchController implements Initializable, DataInitializable<Collector> {
	
	@FXML
	private TextField searchBar;
	
	@FXML
	private RadioButton myCheck, publicCheck, sharedCheck;
	
	@FXML
	private Button searchButton;
	
	@FXML
	private TableView<Disk> disksTableView;
	
	@FXML
	private TableColumn<Disk, String> titleTableColumn, artistTableColumn;
	
	@FXML
	private TableColumn<Disk, Button> manageTableColumn;
	
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collection collection;
	private Collector collector;
	private ObservableList<Disk> disksList;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		searchButton.disableProperty().bind(
				searchBar.textProperty().isEmpty());

		titleTableColumn.setCellValueFactory(new PropertyValueFactory<Disk, String>("titolo"));
		//artistTableColumn.setCellValueFactory(new PropertyValueFactory<Disk, String>("artist"));
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
			final Button viewButton = new Button("View");
			viewButton.setOnAction((ActionEvent event) -> {
				dispatcher.renderView("disk",new Triple<Collector, Collection, Disk>(collector, null, param.getValue()));
			});
			return new SimpleObjectProperty<Button>(viewButton);
		});

		
	}
	
	public void initializeData(Collector collector) {
		this.collector = collector;
	}

	@FXML
	private void search() {

		try {
			

			if ((!this.myCheck.isSelected()
					&& !this.publicCheck.isSelected() && !this.sharedCheck.isSelected()))
				return;

			List<Disk> disks = implementation.getDisksByString(this.searchBar.getText(), collector, this.myCheck.isSelected(), this.sharedCheck.isSelected(),
					this.publicCheck.isSelected());
			disksList = FXCollections.observableArrayList(disks);
			disksTableView.setItems((ObservableList<Disk>) disksList);

		} catch (DatabaseConnectionException e) {
			e.printStackTrace();
		}

	}


}
