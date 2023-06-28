package it.univaq.disim.collectors;

import it.univaq.disim.collectors.business.db.DBImplementation;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class MyApp extends Application {
	//private static DBImplementation dbImplementation;

	public static void main(String[] args) {
		launch(args);
	}

	@Override
	public void start(Stage stage) throws Exception {
		//dbImplementation = new DBImplementation();

        ViewDispatcher.getInstance().login(stage);

        stage.setOnCloseRequest(event -> {
            try {
                DBImplementation dbImplementation = new DBImplementation();
                dbImplementation.getConnection().disconnect();
            } catch (DatabaseConnectionException e) {
                e.printStackTrace();
            }
        });
    }
}