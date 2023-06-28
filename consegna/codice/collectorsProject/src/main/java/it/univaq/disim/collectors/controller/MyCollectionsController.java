package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.List;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collection.Flag;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.domain.Couple;
import it.univaq.disim.collectors.view.ViewDispatcher;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.scene.control.cell.PropertyValueFactory;

public class MyCollectionsController implements Initializable, DataInitializable<Collector>{
	
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collector collector;
	private ObservableList<Collection> collectionsData;
	
	@FXML
	private TableView<Collection> collectionsTableView;
	
	@FXML
	private TableColumn<Collection, String> nameTableColumn;
	
	@FXML
	private TableColumn<Collection, Flag> statusTableColumn;
	
	@FXML
	private TableColumn<Collection, Button> actionTableColumn;
	
	@FXML
	private TableColumn<Collection, Button> editTableColumn;
	
	@FXML
	private TableColumn<Collection, Button> deleteTableColumn;
	
	@FXML
	private TableColumn<Collection, Button> shareTableColumn;
	
	
	
	
	
	@FXML
	public void addAction(ActionEvent event) {
		dispatcher.renderView("addCollection", collector);
		
	}

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		nameTableColumn.setCellValueFactory(new PropertyValueFactory<Collection, String>("name"));

		statusTableColumn.setStyle("-fx-alignment: CENTER;");
		statusTableColumn.setCellValueFactory(new PropertyValueFactory<Collection, Flag>("flag"));

		actionTableColumn.setStyle("-fx-alignment: CENTER;");
		actionTableColumn.setCellValueFactory((CellDataFeatures<Collection, Button> param) -> {
			final Button viewButton = new Button("View");
			viewButton.setStyle(
					"-fx-background-color:#fcbdea; -fx-background-radius: 10px; -fx-text-fill: #5f6569;");
			viewButton.setOnAction((ActionEvent event) -> {
				dispatcher.renderView("collection", new Couple<Collection, Collector>(param.getValue(), collector));
			});
			return new SimpleObjectProperty<Button>(viewButton);
		});
		editTableColumn.setStyle("-fx-alignment: CENTER;");
		editTableColumn.setCellValueFactory((CellDataFeatures<Collection, Button> param) -> {
			final Button editButton = new Button("Edit");
			editButton.setStyle(
					"-fx-background-color:#fcbdea; -fx-background-radius: 10px; -fx-text-fill: #5f6569;");
			editButton.setOnAction((ActionEvent event) -> {
				try {
					implementation.editStatus(param.getValue().getId());
					List<Collection> collections = implementation.collectionsOwned(collector);
		            collectionsData.setAll(collections);
				} catch (DatabaseConnectionException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			});
			
			return new SimpleObjectProperty<Button>(editButton);
		});
		deleteTableColumn.setStyle("-fx-alignment: CENTER;");
		deleteTableColumn.setCellValueFactory((CellDataFeatures<Collection, Button> param) -> {
			final Button deleteButton = new Button("Delete");
			deleteButton.setStyle(
					"-fx-background-color:#fcbdea; -fx-background-radius: 10px; -fx-text-fill: #5f6569;");
			deleteButton.setOnAction((ActionEvent event) -> {
				try {
					implementation.deleteCollection(param.getValue().getId());
					collectionsData.remove(param.getValue()); // Rimuovi la collezione dalla lista dei dati della tabella
		            collectionsTableView.refresh();
				} catch (DatabaseConnectionException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			});
			return new SimpleObjectProperty<Button>(deleteButton);
		});
		shareTableColumn.setStyle("-fx-alignment: CENTER;");
		shareTableColumn.setCellValueFactory((CellDataFeatures<Collection, Button> param) -> {
			final Button shareButton = new Button("Share");
			shareButton.setStyle(
					"-fx-background-color:#fcbdea; -fx-background-radius: 15px; -fx-text-fill: #5f6569; -fx-font-weight: bold;");
			shareButton.setOnAction((ActionEvent event) -> {
				dispatcher.renderView("share", new Couple<Collection, Collector>(param.getValue(), collector));
				
			});
			return new SimpleObjectProperty<Button>(shareButton);
		});
		
		

	}
	
	
	public void initializeData(Collector collector) {

		this.collector = collector;

		try {

			List<Collection> collections = implementation.collectionsOwned(collector);
			collectionsData = FXCollections.observableArrayList(collections);
			collectionsTableView.setItems((ObservableList<Collection>) collectionsData);

		} catch (DatabaseConnectionException e) {
			System.err.println(e.getMessage());
		}
	}


}