package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.Collections;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.geometry.Insets;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.Background;
import javafx.scene.layout.BackgroundFill;
import javafx.scene.layout.BackgroundImage;
import javafx.scene.layout.BackgroundPosition;
import javafx.scene.layout.BackgroundRepeat;
import javafx.scene.layout.BackgroundSize;
import javafx.scene.layout.CornerRadii;
import javafx.scene.paint.Color;

public class LoginController implements Initializable {
	
	@FXML
	private Label errorLabel;
	
	@FXML
	
	private AnchorPane anchor;

	@FXML
	private TextField usernameField;

	@FXML
	private TextField passwordField;

	@FXML
	private Button loginButton;
	
	@FXML
	private Button signUpButton;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		loginButton.disableProperty().bind(
				usernameField.textProperty().isEmpty()
				.or(passwordField.textProperty().isEmpty()));
		anchor.setBackground(new Background(
				Collections.singletonList(new BackgroundFill(Color.WHITE, new CornerRadii(500), new Insets(0))),
				Collections.singletonList(new BackgroundImage(
						new Image("viste/images/disk.jpg", 620, 420, false, true), BackgroundRepeat.NO_REPEAT,
						BackgroundRepeat.NO_REPEAT, BackgroundPosition.CENTER, BackgroundSize.DEFAULT))));

		
	}
	
	@FXML
	public void loginAction(ActionEvent event) {
		if (!("user".equals(usernameField.getText()) &&
			"user".equals(passwordField.getText()))) {
			errorLabel.setText("login e/o password non corretti!");
		} else {
			ViewDispatcher dispatcher = ViewDispatcher.getInstance();
			dispatcher.loggedIn();
		}
		
	}

	
	@FXML
	public void signUpAction(ActionEvent event) {
		ViewDispatcher dispatcher = ViewDispatcher.getInstance();
		dispatcher.renderView("signUp");
		
		
	}

}
