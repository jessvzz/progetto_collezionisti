package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;

public class HomeController implements Initializable{

	@FXML
	private Label benvenutoLabel;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		benvenutoLabel.setText("Benvenuto!");
	}
	
	
	@FXML
	public void goToCollections(ActionEvent event) {
		ViewDispatcher dispatcher = ViewDispatcher.getInstance();
		dispatcher.renderView("collections");
	}
	@FXML
	public void goToFirends(ActionEvent event) {
		ViewDispatcher dispatcher = ViewDispatcher.getInstance();
		dispatcher.renderView("sharedCollections");
	}
	

}
