package br.com.nameproject.pageobjects;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import br.com.nameproject.factories.DriverFactory;
import br.com.nameproject.models.Mensagens;

public class PaginaInicial extends DriverFactory {
	
	public PaginaInicial(WebDriver driver) {
		super(driver);
	}

	/**
	 * Metodo para voltar as movimentações padrão
	 */
    public PaginaInicial resetarMovimentacoes() {
        clicar(driver(), By.xpath("//a[contains(text(),'reset')]"));
        elementoExiste(
    		driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.ResetarComSucesso + "')]"),
            "Erro ao resetar as movimentações!"
        );
        return this;
    }

    /**
     * Metodo para acessar a tela de adicionar conta
     */
    public PaginaContaIncluir acessarAdicionarConta() {
        clicar(driver(), By.xpath("//a[contains(text(),'Contas')]"));
        clicar(driver(), By.xpath("//a[contains(text(),'Adicionar')]"));
        elementoExiste(driver(), By.id("nome"), "Erro ao acessar a página de adicionar conta");
        return new PaginaContaIncluir(driver());
    }

    /**
     * Metodo para acessar a tela de listar contas
     */
    public PaginaContaListar acessarListaContas() {
    	clicar(driver(), By.xpath("//a[contains(text(),'Contas')]"));
    	clicar(driver(), By.xpath("//a[contains(text(),'Listar')]"));
        elementoExiste(driver(), By.xpath("//th[contains(text(),'Conta')]"), "Erro ao acessar a página de listar contas");
        return new PaginaContaListar(driver());
    }

}