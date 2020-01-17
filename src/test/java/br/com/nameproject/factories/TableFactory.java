package br.com.nameproject.factories;

import java.util.List;

import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

public class TableFactory extends DriverFactory {	
	
	public TableFactory(WebDriver driver) {
		super(driver);
	}
	
	/**
	 * Método para atualizar a table após realizar uma operação
	 */
	public TableFactory atualizarTable() {
		return new TableFactory(driver());
	}

	/**
	 * Método que retorna todos os registros <tr> da tabela 
	 */
	public List<WebElement> retornarTrs() {
		return esperaExistencia(driver(), By.tagName("tbody")).findElements(By.tagName("tr"));
	}
	
	/**
	 * Método que retorna todos os registros <tr> da tabela da index informada
	 * Necessário quando a página tem mais de uma table
	 */
	public List<WebElement> retornarTrs(int index) {
		return colecaoElementos(driver(), By.tagName("tbody")).get(index).findElements(By.tagName("tr"));
	}
	
	/**
	 * Método que retorna apenas um registro <tr> conforme index informada
	 */
	public WebElement retornarTr(int index) {
		return retornarTrs().get(index);
	}
	
	/**
	 * Método que retorna apenas um registro <tr> conforme index informada
	 * Necessário quando a página tem mais de uma table
	 */
	public WebElement retornarTr(int table, int col) {
		return retornarTrs(table).get(col);
	}
	
	/**
	 * Método que retorna a coluna <td> da <tr> conforme index informada 
	 */
	public WebElement retornarTd(WebElement tr, int index) {
		return tr.findElements(By.tagName("td")).get(index);
	}
	
	/**
	 * Método que retorna o botão <button> da <td> conforme index informada 
	 */
	public WebElement retornarButton(WebElement coluna, int index) {
		return coluna.findElements(By.tagName("button")).get(index);
	}
	
	/**
	 * Método que retorna o botão link <a> da <td> conforme index informada 
	 */
	public WebElement retornarButtonLink(WebElement coluna, int index) {
		return coluna.findElements(By.tagName("a")).get(index);
	}
	
	/**
	 * Método que retorna o span <span> da <td> conforme index informada 
	 */
	public WebElement retornarSpan(WebElement coluna, int index) {
		return coluna.findElements(By.tagName("span")).get(index);
	}

	/**
	 * Método que retorna a div <div> da <td> conforme index informada 
	 */
	public WebElement retornarDiv(WebElement coluna, int index) {
		return coluna.findElements(By.tagName("div")).get(index);
	}
	
	/**
	 * Método que verifica se já foram vistos todos os registros e apresenta a mensagem de erro
	 */
	public void verificarUltimoRegistro(int index, String msgErro) {
		if(retornarTrs().size() == (index+1)) {
			Assert.fail(msgErro);
		}
	}	
	
}
