package br.com.nameproject.models;

import br.com.nameproject.support.Utilitario;

public class Usuario {

	public Usuario() {
		this.nome = "Fabio Alves";
		this.email = "fabioaraujo.alves@email.com";
		this.emailCadastro = "fabioaraujo.alves@email.com" + Utilitario.retornaDataHora();
		this.senha = "123456";
	}

	public String nome;
	public String email;	
	public String emailCadastro;
	public String senha;

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getEmailCadastro() {
		return emailCadastro;
	}

	public void setEmailCadastro(String emailCadastro) {
		this.emailCadastro = emailCadastro;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

}
