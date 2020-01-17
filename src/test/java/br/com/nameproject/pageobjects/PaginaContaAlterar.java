package br.com.nameproject.pageobjects;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import br.com.nameproject.factories.TableFactory;
import br.com.nameproject.models.Mensagens;

public class PaginaContaAlterar extends TableFactory {

	public PaginaContaAlterar(WebDriver driver) {
		super(driver);
	}
	
	public void realizarAlteracaoConta(String conta) {
        limparTexto(driver(), By.id("nome"));
        inserirTexto(driver(), By.id("nome"), conta);            
    }

    public void verificarAlteracaoComSucesso(String conta) {
        clicar(driver(), By.xpath("//button[@class='btn btn-primary']"));
        elementoExiste(
    		driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.ContaAlteradaComSucesso + "')]"),
            "N�o foi apresentada mensagem de conta alterada com sucesso!"
        );
        validarAlteracaoConta(conta);
    }

    public void validarCamposObrigatorios() {
        limparTexto(driver(), By.id("nome"));
        clicar(driver(), By.xpath("//button[@class='btn btn-primary']"));
        elementoExiste(
    		driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.ContaObrigatorio + "')]"),
            "N�o foi apresentada mensagem de nome da conta obrigat�rio"
        );
    }

    public void validarRegistroDuplicado() {
        clicar(driver(), By.xpath("//button[@class='btn btn-primary']"));
        elementoExiste(
    		driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.ContaJaIncluida + "')]"),
            "N�o foi apresentada mensagem de registro duplicado"
        );
    }

    public void validarAlteracaoConta(String conta) {
        for (int index = 0; index < retornarTrs().size(); index++) {
            String nomeConta = retornarTd(retornarTr(index), 0).getText();
            if (nomeConta.equals(conta)) return;
            verificarUltimoRegistro(index, "Conta n�o foi alterada corretamente");
        }
    }

}