package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.ResourceBundle;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;

public class HomeController implements Initializable {

	@FXML
	private Label benvenutoLabel;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		benvenutoLabel.setText("Benvenuto!");
	}

}
