package it.univaq.disim.collectors.controller;


import java.net.URL;
import java.time.LocalDate;
import java.util.List;
import java.util.ResourceBundle;
import it.univaq.disim.collectors.domain.*;
import it.univaq.disim.collectors.view.ViewDispatcher;
import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.controller.DataInitializable;
import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.VBox;
import javafx.util.StringConverter;

public class CollectionController implements Initializable, DataInitializable<Couple<Collection, Collector>> {
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collection collection;
	private Collector collector;
	private ObservableList<Disk> discosData;

	@FXML
	private Label nameLabel;

	@FXML
	private Button addButton, addExisting;


	@FXML
	private TableView<Disk> disksTableView;

	@FXML
	private TableColumn<Disk, String> nameTableColumn;

	@FXML
	private TableColumn<Disk, Button> actionTableColumn;
	
	@FXML
	private TableColumn<Disk, Button> editTableColumn;



	@Override
	public void initialize(URL location, ResourceBundle resources) {

		nameTableColumn.setCellValueFactory(new PropertyValueFactory<Disk, String>("titolo"));

		actionTableColumn.setStyle("-fx-alignment: CENTER;");
		actionTableColumn.setCellValueFactory((CellDataFeatures<Disk, Button> param) -> {
			final Button viewButton = new Button("View");
			viewButton.setOnAction((ActionEvent event) -> {
				dispatcher.renderView("disk",
						new Triple<Collector, Collection, Disk>(collector, collection, param.getValue()));
			});
			return new SimpleObjectProperty<Button>(viewButton);
		});
		editTableColumn.setStyle("-fx-alignment: CENTER;");
		editTableColumn.setCellValueFactory((CellDataFeatures<Disk, Button> param) -> {
			final Button editButton = new Button("Edit");
			editButton.setOnAction((ActionEvent event) -> {
				dispatcher.renderView("addDisk",
						new Triple<Collector, Collection, Disk>(collector, collection, param.getValue()));
			});
			return new SimpleObjectProperty<Button>(editButton);
		});


	}

	public void initializeData(Couple<Collection, Collector> couple) {
		this.collection = couple.getFirst();
		this.collector = couple.getSecond();
		if(this.collection.getCollector()!= collector.getId()) {
			addButton.setVisible(false);
			addExisting.setVisible(false);
			editTableColumn.setVisible(false);
		}

		nameLabel.setStyle("-fx-font-style: italic;");
		nameLabel.setText(collection.getName());

		try {
			List<Disk> albums = implementation.getDisksInCollection(collection.getId());
			discosData = FXCollections.observableArrayList(albums);
			disksTableView.setItems((ObservableList<Disk>) discosData);
			
		} catch (

		DatabaseConnectionException e) {
			e.printStackTrace();
		}
	}
	
	@FXML
	public void addAction() {

		dispatcher.renderView("addDisk", new Couple<Collection, Collector>(collection, collector));
	}
	
	@FXML
	public void addExisting() {

		dispatcher.renderView("addExistingDisk", new Couple<Collection, Collector>(collection, collector));
	}
	
	


}
