package it.univaq.disim.collectors.view;

import java.io.IOException;

import it.univaq.disim.collectors.controller.DataInitializable;
import it.univaq.disim.collectors.view.View;
import it.univaq.disim.collectors.view.ViewDispatcher;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;

public class ViewDispatcher {
	private static final String SUFFIX = ".fxml";
	private static final String PREFIX = "/viste/";
	private Stage stage;
	private BorderPane pane;
	private Scene scene;
	private static ViewDispatcher dispacher = new ViewDispatcher();
	
	private ViewDispatcher() {}
	
	public static ViewDispatcher getInstance() {
		return dispacher;
	}
	
	public void login(Stage s) {
		this.stage = s;
		Parent loginView = loadView("login").getView();
		Scene scene = new Scene(loginView);
		stage.setScene(scene);
		stage.show();
	}
	
	
	public void logout() {
		try {
			Parent loginView = loadView("login").getView();
			Scene scene = new Scene(loginView);
			stage.setScene(scene);
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(0);
		}
	}	
	
	public<T> void renderView(String nomeVista,T dato){
		try {
			View<T> view = loadView(nomeVista);
			DataInitializable<T> controller = view.getController();
			controller.initializeData(dato);
			Parent	p = view.getView();
			pane.setCenter(p);
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(0);
		}
	}
	
	public<T> void renderHome(T dato){
		try {
			View<T> homeView = loadView("layout");
			DataInitializable<T> controller = homeView.getController();
			controller.initializeData(dato);
			pane = (BorderPane) homeView.getView();
			renderView("home", dato);
			Scene scene = new Scene(pane);
			scene.getStylesheets().add(getClass().getResource(PREFIX + "styles.css").toExternalForm());
			stage.setScene(scene);
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(0);
		}
	}
	
	
	private <T> View<T> loadView(String nomeVista) {
		try {
			FXMLLoader loader= new FXMLLoader(getClass().getResource(PREFIX+nomeVista+SUFFIX));
			View<T> vista = new View<T>(loader.load(), loader.getController());
			return vista;
		}catch(Exception e) {
			e.printStackTrace();
			System.exit(0);
		}
		return null;
	}
}