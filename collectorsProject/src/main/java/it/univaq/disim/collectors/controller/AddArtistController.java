package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.business.BusinessFactory;
import it.univaq.disim.collectors.business.db.Query_JDBC;
import it.univaq.disim.collectors.domain.Collection;
import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.event.Event;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.image.ImageView;

public class AddArtistController implements Initializable, DataInitializable<Collector>{
	private ViewDispatcher dispatcher = ViewDispatcher.getInstance();
	private Query_JDBC implementation = BusinessFactory.getImplementation();

	private Collector collector;
	
	@FXML
	private ImageView artist, label;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		artist.setPickOnBounds(true);

        artist.setOnMouseClicked(new EventHandler() {
            @Override
            public void handle(Event event) {
            	ViewDispatcher dispatcher = ViewDispatcher.getInstance();
        		dispatcher.renderView("artist", collector);
               
            }
        });
        
        label.setPickOnBounds(true);

        label.setOnMouseClicked(new EventHandler() {
            @Override
            public void handle(Event event) {
            	ViewDispatcher dispatcher = ViewDispatcher.getInstance();
        		dispatcher.renderView("label", collector);
               
            }
        });
	}
	
	public void initializeData(Collector collector) {
		this.collector = collector;
	}

}
