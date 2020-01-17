package br.com.nameproject.pageobjects;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import br.com.nameproject.factories.DriverFactory;
import br.com.nameproject.models.ConfiguracaoAmbiente;
import br.com.nameproject.models.Mensagens;
import br.com.nameproject.support.EnumAmbiente;

public class PaginaLogin extends DriverFactory {
	
	public PaginaLogin(WebDriver driver) {
		super(driver);
	}

	public PaginaLogin acessarPaginaLogin(EnumAmbiente ambiente) {
        if (ambiente.equals(EnumAmbiente.TST))
            navegar(ConfiguracaoAmbiente.UrlTst);
        else if (ambiente.equals(EnumAmbiente.HML))
        	navegar(ConfiguracaoAmbiente.UrlHml);
        elementoExiste(driver(), By.id("email"), "Erro ao acessar a p�gina de autentica��o");
        return this;
    }

    public PaginaCadastro acessarCadastroUsuario() {
        clicar(driver(), By.xpath("//a[contains(text(),'Novo usu�rio?')]"));
        return new PaginaCadastro(driver());
    }

    public PaginaLogin realizarLogin(String usuario, String senha) {
        inserirTexto(driver(), By.id("email"), usuario);
        inserirTexto(driver(), By.id("senha"), senha);
        return this;
    }

    public PaginaInicial verificarUsuarioAutenticadoComSucesso() {
        clicar(driver(), By.xpath("//button[contains(text(),'Entrar')]"));
        elementoExiste(
    		driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.LoginRealizadoComSucesso + "')]"),
            "Ocorreu um erro ao realizar o login no sistema"
        );
        return new PaginaInicial(driver());
    }

    public void validarLoginInvalido() {
        clicar(driver(), By.xpath("//button[contains(text(),'Entrar')]"));
        elementoExiste(
    		driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.LoginInvalido + "')]"),
            "N�o foi apresentada mensagem de login inv�lido"
        );
    }

    public void validarCamposObrigatorios(String email, String senha) {
        clicar(driver(), By.xpath("//button[contains(text(),'Entrar')]"));
        if (email.isEmpty()) {
            elementoExiste(
        		driver(),
                By.xpath("//div[contains(text(),'Email � um " + Mensagens.CampoObrigorio + "')]"),
                "N�o foi apresentada mensagem de email obrigat�rio"
            );
        }
        if (senha.isEmpty()) {
            elementoExiste(
        		driver(),
                By.xpath("//div[contains(text(),'Senha � um " + Mensagens.CampoObrigorio + "')]"),
                "N�o foi apresentada mensagem de senha obrigat�ria"
            );
        }
    }

}