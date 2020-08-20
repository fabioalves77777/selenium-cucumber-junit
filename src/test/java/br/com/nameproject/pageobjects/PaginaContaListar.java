package br.com.nameproject.pageobjects;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;

import br.com.nameproject.factories.TableFactory;
import br.com.nameproject.models.Mensagens;

public class PaginaContaListar extends TableFactory {

	public PaginaContaListar(WebDriver driver) {
		super(driver);
	}
	
	public PaginaContaAlterar acessarAlteracaoConta() {
        int index = 0;
        for (WebElement tr : retornarTrs()) {
            if (retornarTd(tr, 0).getText().contains("Conta para alterar")) {
                clicar(retornarButtonLink(retornarTd(tr, 1), 0));
                break;
            }
            verificarUltimoRegistro(index++, "Não foi encontrada a conta com o nome 'Conta para alterar'");
        }
        return new PaginaContaAlterar(driver());
    }

    /**
     * Metodo para solicitar exclusao de conta em uso com o nome "Conta com movimentacao"
     */
    public void realizarExclusaoContaComMovimentacao() {
        int index = 0;
        for (WebElement tr : retornarTrs()) {
            if (retornarTd(tr, 0).getText().contains("Conta com movimentacao")) {
                clicar(retornarButtonLink(retornarTd(tr, 1), 1));
                break;
            }
            verificarUltimoRegistro(index++, "Não foi encontrada a conta com o nome 'Conta com movimentacao'");
        }
    }

    /**
     * Metodo para validar exclusao de conta em uso da conta com o nome "Conta com movimentacao"
     */
    public void validarExclusaoContaComMovimentacao() {
        elementoExiste(
            driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.ContaComMovimentacoes + "')]"),
            "Não foi apresentada mensagem de exclusão de conta não permitida!"
        );
    }

    /**
     * Metodo para excluir conta
     */
    public void realizarExclusaoConta(String conta) {
        for (int i = 0; i < retornarTrs().size(); i++) {
            if (retornarTd(retornarTr(i), 0).getText().equals(conta)) {
                clicar(retornarButtonLink(retornarTd(retornarTr(i), 1), 1));
                return;
            }
        }        
    }

    /**
     * Metodo para verificar exclusão de conta
     */
    public void verificarContaExcluidaComSucesso() {
        elementoExiste(
            driver(),
            By.xpath("//div[contains(text(),'" + Mensagens.ContaRemovidaComSucesso + "')]"),
            "Não foi apresentada mensagem de exclusão realizada com sucesso!"
        );
    }

}