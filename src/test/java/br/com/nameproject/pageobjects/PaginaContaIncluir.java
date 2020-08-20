package br.com.nameproject.pageobjects;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import br.com.nameproject.factories.TableFactory;
import br.com.nameproject.models.Mensagens;

public class PaginaContaIncluir extends TableFactory {

	public PaginaContaIncluir(WebDriver driver) {
		super(driver);
	}
	
	public PaginaContaListar acessarListaContas() {
        clicar(driver(), By.xpath("//a[contains(text(),'Contas')]"));
        clicar(driver(), By.xpath("//a[contains(text(),'Listar')]"));
        elementoExiste(driver(), By.xpath("//th[contains(text(),'Conta')]"), "Erro ao acessar a página de listar contas");
        return new PaginaContaListar(driver());
    }

    public void realizarInclusaoConta(String conta) {
        inserirTexto(driver(), By.id("nome"), conta);            
    }

    public void verificarContaAdicionadaComSucesso(String conta) {
    	clicar(driver(), By.xpath("//button[@class='btn btn-primary']"));
        elementoExiste(
    		driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.ContaAdicionadaComSucesso + "')]"),
            "Não foi apresentada mensagem de conta adicionada com sucesso!"
        );
        validarInclusaoConta(conta);
    }

    public void validarCamposObrigatorios(String nome) {
    	clicar(driver(), By.xpath("//button[@class='btn btn-primary']"));
        if (nome.isEmpty()) {
            elementoExiste(
        		driver(),
                By.xpath("//div[contains(text(),'" + Mensagens.ContaObrigatorio + "')]"),
                "Não foi apresentada mensagem de nome da conta obrigatório"
            );
        }            
    }

    public void validarRegistroDuplicado() {
    	clicar(driver(), By.xpath("//button[@class='btn btn-primary']"));
        elementoExiste(
    		driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.ContaJaIncluida + "')]"),
            "Não foi apresentada mensagem de registro duplicado"
        );
    }

    public void validarInclusaoConta(String conta) {
        int index = 0;
        for (WebElement tr : retornarTrs()) {
            String nomeConta = retornarTd(tr, 0).getText();
            if (nomeConta.equals(conta)) return;
            verificarUltimoRegistro(index++, "Conta não foi adicionada corretamente");
        }
    }

}