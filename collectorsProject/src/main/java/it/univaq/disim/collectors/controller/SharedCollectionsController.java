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

public class SharedCollectionsController implements Initializable, DataInitializable<Collector>{
	
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
	
	
	
	

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		nameTableColumn.setCellValueFactory(new PropertyValueFactory<Collection, String>("name"));

		statusTableColumn.setStyle("-fx-alignment: CENTER;");
		statusTableColumn.setCellValueFactory(new PropertyValueFactory<Collection, Flag>("flag"));

		actionTableColumn.setStyle("-fx-alignment: CENTER;");
		actionTableColumn.setCellValueFactory((CellDataFeatures<Collection, Button> param) -> {
			final Button viewButton = new Button("View");
			viewButton.setStyle(
					"-fx-background-color:#bacad7; -fx-background-radius: 15px; -fx-text-fill: #5f6569; -fx-font-weight: bold;");
			viewButton.setOnAction((ActionEvent event) -> {
				dispatcher.renderView("collection", new Couple<Collection, Collector>(param.getValue(), collector));
			});
			return new SimpleObjectProperty<Button>(viewButton);
		});

	}
	
	
	public void initializeData(Collector collector) {

		this.collector = collector;

		try {

			List<Collection> collections = implementation.collectionsShared(collector);
			collectionsData = FXCollections.observableArrayList(collections);
			collectionsTableView.setItems((ObservableList<Collection>) collectionsData);

		} catch (DatabaseConnectionException e) {
			System.err.println(e.getMessage());
		}
	}


}