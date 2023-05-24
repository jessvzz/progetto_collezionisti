package it.univaq.disim.collectors.view;

import java.io.IOException;

import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;

public class ViewDispatcher {
	private static final String FXML_SUFFIX = ".fxml";
	private static final String RESOURCE_BASE = "/viste/";

	private static ViewDispatcher instance = new ViewDispatcher();

	private Stage stage;
	private BorderPane layout;

	private ViewDispatcher() {
	}

	public static ViewDispatcher getInstance() {
		return instance;
	}

	public void loginView(Stage stage) throws ViewException {
		this.stage = stage;
		Parent loginView = loadView("login");
		Scene scene = new Scene(loginView);
		stage.setScene(scene);
		stage.show();
	}

	public void loggedIn() {
		try {
			layout = (BorderPane) loadView("layout");
			Parent home = loadView("home");
			layout.setCenter(home);
			Scene scene = new Scene(layout);
			stage.setScene(scene);
		} catch (ViewException e) {
			e.printStackTrace();
			renderError(e);
		}
	}

	public void logout() {
		try {
			Parent loginView = loadView("login");
			Scene scene = new Scene(loginView);
			stage.setScene(scene);
		} catch (ViewException e) {
			renderError(e);
		}
	}

	public void renderView(String viewName) {
		try {
			Parent view = loadView(viewName);
			layout.setCenter(view);
		} catch (ViewException e) {
			renderError(e);
		}
	}

	private void renderError(ViewException e) {
		e.printStackTrace();
		System.exit(1);
	}

	private Parent loadView(String view) throws ViewException {
		try {
			FXMLLoader loader = new FXMLLoader(getClass().getResource(RESOURCE_BASE + view + FXML_SUFFIX));
			return loader.load();
		} catch (IOException e) {
			e.printStackTrace();
			throw new ViewException(e);
		}
	}

}
