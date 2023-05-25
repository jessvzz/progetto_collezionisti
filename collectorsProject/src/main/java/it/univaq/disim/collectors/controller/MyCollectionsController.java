package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;

public class MyCollectionsController implements Initializable{
	
	
	@FXML
	public void addAction(ActionEvent event) {
		ViewDispatcher dispatcher = ViewDispatcher.getInstance();
		dispatcher.renderView("addCollection");
		
	}

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		// TODO Auto-generated method stub
		
	}

}