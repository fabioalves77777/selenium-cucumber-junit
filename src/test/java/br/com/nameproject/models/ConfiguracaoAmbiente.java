package br.com.nameproject.models;

import br.com.nameproject.support.EnumAmbiente;
import br.com.nameproject.support.EnumNavegador;

public class ConfiguracaoAmbiente {

	public ConfiguracaoAmbiente() {
		this.navegador = EnumNavegador.CHROME;
		this.ambiente = EnumAmbiente.TST;
	}

	public Enum<?> navegador;
	public Enum<?> ambiente;
	public static String UrlTst = "https://seubarriga.wcaquino.me/login";
    public static String UrlHml = "https://seubarriga.wcaquino.me/login";

	public void setNavegador(Enum<?> Navegador) {
		this.navegador = Navegador;
	}

	public Enum<?> getNavegador() {
		return navegador;
	}

	public Enum<?> getAmbiente() {
		return ambiente;
	}

	public void setAmbiente(Enum<?> ambiente) {
		this.ambiente = ambiente;
	}

}
