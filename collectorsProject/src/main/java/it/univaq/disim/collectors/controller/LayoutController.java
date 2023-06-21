package it.univaq.disim.collectors.controller;

import java.net.URL;
import java.util.ResourceBundle;

import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Separator;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Paint;

public class LayoutController implements Initializable {
	private static final MenuElement MENU_HOME = new MenuElement("Home", "home");
	private static final MenuElement[] MENU_USERS = {
			new MenuElement("My Collections", "collections"),
			new MenuElement("Friends' Collections", "friendsCollections"),
			new MenuElement("Shared Collections", "shared"),
			new MenuElement("Settings", "settings"),
			new MenuElement("Search", "search"),
		 };
	
	@FXML
	private VBox menuBar;

	@Override
	public void initialize(URL location, ResourceBundle resources) {
		menuBar.getChildren().addAll(createButton(MENU_HOME));
		menuBar.getChildren().add(new Separator());
		for (MenuElement menu : MENU_USERS) {
			menuBar.getChildren().add(createButton(menu));
		}
	}
	
	
	private Button createButton(MenuElement viewItem) {
		Button button = new Button(viewItem.getNome());
		button.setStyle("-fx-background-color: transparent; -fx-font-size: 14;");
		button.setTextFill(Paint.valueOf("black"));
		button.setPrefHeight(10);
		button.setPrefWidth(180);
		button.setOnAction((ActionEvent event) -> {
			ViewDispatcher dispatcher = ViewDispatcher.getInstance();
			dispatcher.renderView(viewItem.getVista());
		});
		return button;
	}
	
	@FXML
	public void exit(ActionEvent event) {
		ViewDispatcher dispatcher = ViewDispatcher.getInstance();
		dispatcher.logout();
	}
	


}
