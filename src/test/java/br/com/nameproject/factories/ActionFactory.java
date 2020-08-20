package br.com.nameproject.factories;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;
import java.util.ArrayList;
import java.util.List;

import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.ElementClickInterceptedException;
import org.openqa.selenium.ElementNotInteractableException;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.Select;
import org.openqa.selenium.support.ui.WebDriverWait;

public class ActionFactory {
	public int TempoLimiteEspera = 30;
	public int ElementoExistente = 7;

	/**
	 * Metodo para esperar a existencia do elemento HTML
	 */
	public WebElement esperaExistencia(WebDriver driver, By by) {
		for (int i = 0; i < TempoLimiteEspera; i++) {
			try {
				return driver.findElement(by);
			} catch (NoSuchElementException e1) {
				sleep(500);
			}
		}
		throw new NoSuchElementException("Elemento não encontrado: '" + by.toString());
	}

	/**
	 * Metodo para esperar a exist�ncia do elemento HTML e inserir texto
	 */
	public void esperaExistenciaSendKeys(WebDriver driver, By by, String text) {
		for (int i = 0; i < TempoLimiteEspera; i++) {
			try {
				driver.findElement(by).sendKeys(text);
				return;
			} catch (NoSuchElementException e1) {
				sleep(500);
			} catch (ElementNotInteractableException e2) {
				sleep(500);
			}
		}
		throw new NoSuchElementException("Elemento não pode ser digitado: '" + by.toString());
	}
	
	/**
	 * Metodo para esperar a existencia do elemento HTML e inserir texto
	 */
	public void esperaExistenciaSendKeys(WebElement element, String text) {
		for (int i = 0; i < TempoLimiteEspera; i++) {
			try {
				element.sendKeys(text);
				return;
			} catch (NoSuchElementException e1) {
				sleep(500);
			} catch (ElementNotInteractableException e2) {
				sleep(500);
			}
		}
		throw new NoSuchElementException("Elemento não pode ser digitado: '" + element.toString());
	}

	/**
	 * Metodo para esperar a existencia do elemento HTML e inserir key
	 */
	public void esperaExistenciaSendKeys(WebDriver driver, By by, Keys key) {
		for (int i = 0; i < TempoLimiteEspera; i++) {
			try {
				driver.findElement(by).sendKeys(key);
				return;
			} catch (ElementNotInteractableException e2) {
				sleep(500);
			}
		}
		throw new NoSuchElementException("Elemento não pode ser digitado: '" + by.toString());
	}
	
	/**
	 * Metodo para esperar a existencia do elemento HTML e inserir key
	 */
	public void esperaExistenciaSendKeys(WebElement element, Keys key) {
		for (int i = 0; i < TempoLimiteEspera; i++) {
			try {
				element.sendKeys(key);
				return;
			} catch (ElementNotInteractableException e2) {
				sleep(500);
			}
		}
		throw new NoSuchElementException("Elemento não pode ser digitado: '" + element.toString());
	}

	/**
	 * Metodo para esperar a existencia do elemento HTML e clicar
	 */
	public void esperaExistenciaAndClick(WebDriver driver, By by) {
		for (int i = 0; i < TempoLimiteEspera; i++) {
			try {
				esperaExistencia(driver, by).click();
				return;
			} catch (ElementClickInterceptedException e1) {
				sleep(500);
			} catch (ElementNotInteractableException e2) {
				sleep(500);
			} catch (StaleElementReferenceException e3) {
				sleep(500);
			}
		}
		throw new ElementClickInterceptedException("Elemento não pode ser clicado: '" + by.toString());
	}
	
	/**
	 * Metodo para esperar a existencia do elemento HTML e clicar
	 */
	public void esperaExistenciaAndClick(WebElement element) {
		for (int i = 0; i < TempoLimiteEspera; i++) {
			try {
				element.click();
				return;
			} catch (ElementClickInterceptedException e1) {
				sleep(500);
			} catch (ElementNotInteractableException e2) {
				sleep(500);
			} catch (StaleElementReferenceException e3) {
				sleep(500);
			}
		}
		throw new ElementClickInterceptedException("Elemento não pode ser clicado: '" + element.toString());
	}

	/**
	 * Metodo para esperar a existencia de selectByVisibleText
	 */
	public void esperaSelectByVisibleText(Select select, String texto) {
		for (int i = 0; i < TempoLimiteEspera; i++) {
			try {
				select.selectByVisibleText(texto);
			} catch (NoSuchElementException e) {
				sleep(500);
			} catch (ElementClickInterceptedException e) {
				sleep(500);
			} catch (ElementNotInteractableException e) {
				sleep(500);
			} catch (StaleElementReferenceException e) {
				sleep(500);
			}
		}
	}

	/**
	 * Metodo para esperar a existencia de selectByIndex
	 */
	public void esperaSelectByIndex(Select select, int index) {
		for (int i = 0; i < TempoLimiteEspera; i++) {
			try {
				select.selectByIndex(index);
			} catch (NoSuchElementException e) {
				sleep(500);
			} catch (ElementClickInterceptedException e) {
				sleep(500);
			} catch (ElementNotInteractableException e) {
				sleep(500);
			} catch (StaleElementReferenceException e) {
				sleep(500);
			}
		}
	}

	/**
	 * Metodo que verifica se elemento existe
	 */
	public boolean elementoExiste(WebDriver driver, By by) {
		for (int i = 0; i < ElementoExistente; i++) {
			try {
				driver.findElement(by);
				return true;
			} catch (NoSuchElementException e) {
				sleep(500);
			}
		}
		return false;
	}
	
	/**
	 * Metodo que verifica se elemento existe
	 */
	public boolean elementoExiste(WebDriver driver, By by, int timeout) {
		for (int i = 0; i < timeout; i++) {
			try {
				driver.findElement(by);
				return true;
			} catch (NoSuchElementException e) {
				sleep(500);
			}
		}
		return false;
	}

	/**
	 * Metodo que verifica se elemento existe
	 */
	public void elementoExiste(WebDriver driver, By by, String texto) {
		if (!elementoExiste(driver, by)) {
			Assert.fail(texto);
		}
	}

	/**
	 * Metodo que retorna colecao de elementos
	 */
	public List<WebElement> colecaoElementos(WebDriver driver, By by) {
		for (int i = 0; i < TempoLimiteEspera; i++) {
			try {
				driver.findElements(by);
				return driver.findElements(by);
			} catch (NoSuchElementException e) {
				sleep(500);
			}
		}
		throw new NoSuchElementException("Controle não encontrado: '" + by.toString());
	}

	/**
	 * Metodo para limpar um elemento
	 */
	public void limparTexto(WebDriver driver, By by) {
		esperaExistencia(driver, by).clear();
	}

	/**
	 * Metodo para inserir texto em elemento
	 */
	public void inserirTexto(WebDriver driver, By by, String texto) {
		if (!texto.isEmpty())
			esperaExistenciaSendKeys(driver, by, texto);
	}

	/**
	 * Metodo para inserir texto em elemento 
	 */
	public void inserirTexto(WebDriver driver, By by, Keys key) {
		esperaExistenciaSendKeys(driver, by, key);
	}
	
	/**
	 * Metodo para inserir texto em elemento
	 */
	public void inserirTexto(WebElement element, String texto) {
		if (!texto.isEmpty())
			esperaExistenciaSendKeys(element, texto);
	}

	/**
	 * Metodo para inserir texto em elemento 
	 */
	public void inserirTexto(WebElement element, Keys key) {
		esperaExistenciaSendKeys(element, key);
	}
	
	/**
	 * Metodo para inserir texto em elemento pelo atributo value
	 */
	public void inserirTextoAttr(WebDriver driver, WebElement elemento, String texto) {
		((JavascriptExecutor) driver).executeScript(
			"arguments[0].setAttribute(arguments[1], arguments[2]);", 
            elemento, "value", texto
        );
    }

	/**
	 * Metodo para clicar em um elemento
	 */
	public void clicar(WebDriver driver, By by) {
		esperaExistenciaAndClick(driver, by);
	}
	
	/**
	 * Metodo para clicar em um elemento
	 */
	public void clicar(WebElement element) {
		esperaExistenciaAndClick(element);
	}

	/**
	 * Metodo para selecionar elemento pelo texto
	 */
	public void selecionar(WebDriver driver, By by, String texto) {
		if(texto.equals("") || texto == null) { return;	}
		Select select = new Select(esperaExistencia(driver, by));
		esperaSelectByVisibleText(select, texto);
	}
	
	/**
	 * Metodo para selecionar elemento pelo texto
	 */
	public void selecionar(WebElement element, String texto) {
		if(texto.equals("") || texto == null) { return;	}
		Select select = new Select(element);
		esperaSelectByVisibleText(select, texto);
	}

	/**
	 * Metodo para selecionar elemento pelo indice
	 */
	public void selecionar(WebDriver driver, By by, int index) {
		Select select = new Select(esperaExistencia(driver, by));
		esperaSelectByIndex(select, index);
	}
	
	/**
	 * Metodo para selecionar elemento pelo indice
	 */
	public void selecionar(WebElement element, int index) {
		Select select = new Select(element);
		esperaSelectByIndex(select, index);
	}

	/**
	 * Metodo que retorna o texto do elemento
	 */
	public String retornarTexto(WebDriver driver, By by) {
		return esperaExistencia(driver, by).getText();
	}
	
	/**
	 * Metodo que retorna o texto do elemento
	 */
	public String retornarTextoAttr(WebDriver driver, By by) {
		return esperaExistencia(driver, by).getAttribute("value");
	}

	/**
	 * Metodo que verifica se texto atual é igual ao texto esperado
	 */
	public void VerificarTexto(String msgErro, String msgEsperada, String msgAtual) {
		assertEquals(msgErro, msgEsperada, msgAtual);
	}

	/**
	 * Metodo para verificar se texto do elemento contém no texto esperado
	 */
	public void ContemTexto(String msgErro, String msgEsperada, String msgAtual) {
		assertTrue(msgErro, msgAtual.contains(msgEsperada));
	}

	public void sleep(int time) {
		try { 
			Thread.sleep(time);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Metodo que troca de aba
	 */
	public void trocarAba(WebDriver driver, int index) {
		ArrayList<String> tabs = new ArrayList<String> (driver.getWindowHandles());
	    driver.switchTo().window(tabs.get(index));
	}
	
	/**
	 * Metodo que anexa arquivo manualmente
	 */
	public void anexarArquivo(WebDriver driver, String text) {
		StringSelection file = new StringSelection(text);
	    Toolkit.getDefaultToolkit().getSystemClipboard().setContents(file, null);
		try {
			Robot robot = new Robot();
			robot.keyPress(java.awt.event.KeyEvent.VK_ENTER);
		    robot.keyRelease(java.awt.event.KeyEvent.VK_ENTER);
		    robot.keyPress(java.awt.event.KeyEvent.VK_CONTROL);
		    robot.keyPress(java.awt.event.KeyEvent.VK_V);
		    robot.keyRelease(java.awt.event.KeyEvent.VK_CONTROL);
		    sleep(1000);
		    robot.keyPress(java.awt.event.KeyEvent.VK_ENTER);
		} catch (AWTException e) {
			e.printStackTrace();
		}	    
	}
	
	/**
	 * Metodo que espera a pagina carregar completamente
	 */
	public void esperaPaginaCarregar(WebDriver driver) {		
		WebDriverWait wait = new WebDriverWait(driver, 1);
		ExpectedCondition<Boolean> angularLoad = new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver driver) {
                return Boolean.valueOf(((JavascriptExecutor) driver)
                		.executeScript("return "
                				+ "(window.angular !== undefined) && "
                				+ "(angular.element(document).injector() !== undefined) && "
                				+ "(angular.element(document).injector().get('$http').pendingRequests.length === 0)")
                		.toString());
            }
        };
        try { wait.until(angularLoad); } catch (Throwable error) {}       	
    }

}