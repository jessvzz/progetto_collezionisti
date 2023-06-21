package it.univaq.disim.collectors;

import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class MyApp extends Application {

	public static void main(String[] args) {
		launch(args);
	}

	@Override
	public void start(Stage stage) throws Exception {
		try {
		ViewDispatcher.getInstance().login(stage);
		} catch(Exception e) {
			e.printStackTrace();
			System.exit(0);
		}

}}
