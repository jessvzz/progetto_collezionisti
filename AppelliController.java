package it.univaq.disim.oop.myunivaq.controller;

import java.net.URL;
import java.time.LocalDate;
import java.util.List;
import java.util.ResourceBundle;

import it.univaq.disim.oop.myunivaq.business.BusinessException;
import it.univaq.disim.oop.myunivaq.business.InsegnamentoService;
import it.univaq.disim.oop.myunivaq.business.MyUnivaqBusinessFactory;
import it.univaq.disim.oop.myunivaq.domain.Appello;
import it.univaq.disim.oop.myunivaq.domain.Insegnamento;
import it.univaq.disim.oop.myunivaq.view.ViewDispatcher;
import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableColumn.CellDataFeatures;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

public class AppelliController implements Initializable, DataInitializable<Insegnamento> {

	@FXML
	private Label appelliLabel;

	@FXML
	private TableView<Appello> tabellaAppelli;

	@FXML
	private TableColumn<Appello, String> descrizioneTableColumn;

	@FXML
	private TableColumn<Appello, Integer> dataTableColumn;

	@FXML
	private TableColumn<Appello, String> tipologiaEsameTableColumn;

	@FXML
	private TableColumn<Appello, Button> azioniTableColumn;

	private Insegnamento insegnamento;

	private ViewDispatcher dispatcher;

	private InsegnamentoService insegnamentoService;

	public AppelliController() {
		dispatcher = ViewDispatcher.getInstance();
		MyUnivaqBusinessFactory factory = MyUnivaqBusinessFactory.getInstance();
		insegnamentoService = factory.getInsegnamentoService();
	}

	@Override
	public void initialize(URL url, ResourceBundle resourceBundle) {
		descrizioneTableColumn.setCellValueFactory(new PropertyValueFactory<>("descrizione"));
		dataTableColumn.setCellValueFactory(new PropertyValueFactory<>("data"));
		tipologiaEsameTableColumn.setCellValueFactory(new PropertyValueFactory<>("tipologiaEsame"));

		azioniTableColumn.setStyle("-fx-alignment: CENTER;");
		azioniTableColumn.setCellValueFactory((CellDataFeatures<Appello, Button> param) -> {
			final Button appelliButton = new Button("Modifica");
			appelliButton.setOnAction((ActionEvent event) -> {
				dispatcher.renderView("appello", param.getValue());
			});
			return new SimpleObjectProperty<Button>(appelliButton);
		});
	}

	@Override
	public void initializeData(Insegnamento insegnamento) {
		this.insegnamento = insegnamento;
		appelliLabel.setText(appelliLabel.getText() + " " + insegnamento.getDenominazione() + " [" + insegnamento.getCodice() + "]");
		try {
			List<Appello> appelli = insegnamentoService.findAllAppelli(insegnamento);
			ObservableList<Appello> appelliData = FXCollections.observableArrayList(appelli);
			tabellaAppelli.setItems(appelliData);
		} catch (BusinessException e) {
			dispatcher.renderError(e);
		}
	}

	@FXML
	public void aggiungiAppelloAction(ActionEvent event) {
		Appello appello = new Appello();
		appello.setData(1);
		appello.setDescrizione("prodotto test");
		appello.setInsegnamento(insegnamento);
		dispatcher.renderView("appello", appello);
	}
}