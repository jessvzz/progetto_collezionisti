package it.univaq.disim.collectors;

import it.univaq.disim.collectors.business.db.JDBC_mySQL;
import it.univaq.disim.collectors.business.db.DatabaseConnectionException;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class MyApp extends Application {
	//private static JDBC_mySQL dbImplementation;

	public static void main(String[] args) {
		launch(args);
	}

	@Override
	public void start(Stage stage) throws Exception {
		//dbImplementation = new JDBC_mySQL();

        ViewDispatcher.getInstance().login(stage);

        stage.setOnCloseRequest(event -> {
            try {
                JDBC_mySQL dbImplementation = new JDBC_mySQL();
                dbImplementation.getConnection().disconnect();
            } catch (DatabaseConnectionException e) {
                e.printStackTrace();
            }
        });
    }
}