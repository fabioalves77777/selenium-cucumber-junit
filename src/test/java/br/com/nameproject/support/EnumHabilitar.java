package br.com.nameproject.support;

public enum EnumHabilitar {

	SIM("Sim"), NAO("Não");

	EnumHabilitar(String habilitar) {
		this.habilitar = habilitar;
	}

	private String habilitar;

	public String get() {
		return this.habilitar;
	}
	
}
