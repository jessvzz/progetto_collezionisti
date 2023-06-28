package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.domain.Collector;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.event.ActionEvent;
import javafx.event.Event;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;

public class HomeController implements Initializable, DataInitializable<Collector>{

	@FXML
	private Label benvenutoLabel;
	
	@FXML
	private ImageView collectionsImg, friendsImg;
	
	private Collector collector;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		collectionsImg.setPickOnBounds(true);

        collectionsImg.setOnMouseClicked(new EventHandler() {
            @Override
            public void handle(Event event) {
            	ViewDispatcher dispatcher = ViewDispatcher.getInstance();
        		dispatcher.renderView("collections", collector);
               
            }
        });
        
        friendsImg.setPickOnBounds(true);

        friendsImg.setOnMouseClicked(new EventHandler() {
            @Override
            public void handle(Event event) {
            	ViewDispatcher dispatcher = ViewDispatcher.getInstance();
        		dispatcher.renderView("sharedcollections", collector);
               
            }
        });
	}
	
	public void initializeData(Collector collector) {

		benvenutoLabel.setText("Benvenuto " + collector.getName());
		this.collector = collector;

	}

	
	
	

}