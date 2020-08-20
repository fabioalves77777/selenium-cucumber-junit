package br.com.nameproject.stepdefinitions.cadastro;

import br.com.nameproject.models.Usuario;
import br.com.nameproject.pageobjects.PaginaCadastro;
import br.com.nameproject.pageobjects.PaginaLogin;
import br.com.nameproject.support.EnumAmbiente;
import br.com.nameproject.support.Hooks;
import io.cucumber.datatable.DataTable;
import io.cucumber.java.pt.Dado;
import io.cucumber.java.pt.Entao;

public class CadastrarUsuarioSteps {
	
	public PaginaLogin login;
	public PaginaCadastro cadastro;
	Usuario user = new Usuario();
	
	public CadastrarUsuarioSteps(Hooks hooks) {
		login = new PaginaLogin(hooks._driver.driver());
	}

	@Dado("Dado que o usuario queira criar uma conta")
	public void dado_que_o_usuario_queira_criar_uma_conta() {
		cadastro = login
				.acessarPaginaLogin(EnumAmbiente.TST)
				.acessarCadastroUsuario();
	}

	@Dado("E que o usuario informe os dados necessarios para cadastro {string} {string} {string}")
	public void e_que_o_usuario_informe_os_dados_necessarios_para_cadastro(String nome, String email, String senha) {
		cadastro.cadastrarUsuario(nome, email, senha);
	}

	@Dado("E que o usuario informe os dados necessarios para cadastrar")
	public void e_que_o_usuario_informe_os_dados_necessarios_para_cadastro(DataTable table) {
		cadastro.cadastrarUsuario(table.cell(1, 0), table.cell(1, 1), table.cell(1, 2));
	}
	
	@Dado("E que o usuario informe os dados necessarios para cadastro")
	public void e_que_o_usuario_informe_os_dados_necessarios_para_cadastro() {
		cadastro.cadastrarUsuario(user.getNome(), user.getEmailCadastro(), user.getSenha());
	}
	
	@Entao("Entao o usuario e informado que campos obrigatorios do cadastro nao foram preenchidos {string} {string} {string}")
	public void entao_o_usuario_e_informado_que_campos_obrigatorios_do_cadastro_nao_foram_preenchidos(String nome, String email, String senha) {
		cadastro.validarCamposObrigatorios(nome, email, senha);
	}

	@Entao("Entao o usuario e informado que ja existe um registro cadastrado para esse e-mail")
	public void entao_o_usuario_e_informado_que_ja_existe_um_registro_cadastrado_para_esse_e_mail() {
		cadastro.validarRegistroDuplicado();
	}

	@Entao("Entao o usuario e informado que foi realizado o cadastro com sucesso")
	public void entao_o_usuario_e_informado_que_foi_realizado_o_cadastro_com_sucesso() {
		cadastro.verificarUsuarioCadastradoComSucesso();
	}

}
