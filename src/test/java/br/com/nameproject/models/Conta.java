package br.com.nameproject.models;

import br.com.nameproject.support.Utilitario;

public class Conta {

	public Conta() {
		this.nomeIncluir = "Agua " + Utilitario.retornaDataHora();
        this.nomeAlterar = "Luz " + Utilitario.retornaDataHora();
        this.nomeExcluir = "Conta para alterar";
	}

	public String nomeIncluir;
    public String nomeAlterar;
    public String nomeExcluir;
	
}
