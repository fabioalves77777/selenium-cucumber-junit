package br.com.nameproject.pageobjects;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

import br.com.nameproject.factories.DriverFactory;
import br.com.nameproject.models.Mensagens;

public class PaginaCadastro extends DriverFactory {
	
	public PaginaCadastro(WebDriver driver) {
		super(driver);
	}

	public PaginaCadastro cadastrarUsuario(String nome, String email, String senha) {
        inserirTexto(driver(), By.id("nome"), nome);
        inserirTexto(driver(), By.id("email"), email);
        inserirTexto(driver(), By.id("senha"), senha);            
        return this;
    }

    public void verificarUsuarioCadastradoComSucesso() {
        clicar(driver(), By.xpath("//input[@class='btn btn-primary']"));
        elementoExiste(
        	driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.UsuarioCadastrado + "')]"),                
            "Ocorreu um erro ao realizar o cadastro do usuário"
        );
    }

    public void validarCamposObrigatorios(String nome, String email, String senha) {
    	clicar(driver(), By.xpath("//input[@class='btn btn-primary']"));
        if(nome.isEmpty()) {
        	elementoExiste(
            	driver(),
                By.xpath("//div[contains(text(),'Nome é um " + Mensagens.CampoObrigorio + "')]"),
                "Não foi apresentada mensagem de nome obrigatório"
            );
        }
        if (email.isEmpty()) {
        	elementoExiste(
            	driver(),
                By.xpath("//div[contains(text(),'Email é um " + Mensagens.CampoObrigorio + "')]"),
                "Não foi apresentada mensagem de email obrigatório"
            );
        }
        if (senha.isEmpty()) {
        	elementoExiste(
        		driver(),
                By.xpath("//div[contains(text(),'Senha é um " + Mensagens.CampoObrigorio + "')]"),
                "Não foi apresentada mensagem de senha obrigatória"
            );
        }                
    }

    public void validarRegistroDuplicado() {
    	clicar(driver(), By.xpath("//input[@class='btn btn-primary']"));
    	elementoExiste(
        		driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.EmailJaUtilizado + "')]"),
            "Não foi apresentada mensagem de registro duplicado"
        );
    }
    
}