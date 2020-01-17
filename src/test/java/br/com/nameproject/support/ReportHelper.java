package br.com.nameproject.support;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;

public class ReportHelper {
	public static List<File> buscaRecursiva(File pasta, String ext) {
		List<File> resultados = new ArrayList<File>();
		for (File f : pasta.listFiles()) {
			if (f.isDirectory())
				resultados.addAll(buscaRecursiva(f, ext));
			else if (f.getName().endsWith(ext))
				resultados.add(f);
		}
		return resultados;
	}

	public static void report(String pastaHtml, File pasta, String nomeProjeto) {
		File pastaDoRelatorio = new File(pastaHtml);
		List<String> arquivosJson = new ArrayList<>();
		for (int i = 0; i < buscaRecursiva(pasta, "json").size(); i++) {
			String json = buscaRecursiva(pasta, "json").get(i).getAbsolutePath();
			arquivosJson.add(json);
		}
		String numeroBuild = "1";
		String projetoNome = nomeProjeto;
		boolean rodarComJenkins = false;
		boolean testeParalelo = false;
		Configuration configuration = new Configuration(pastaDoRelatorio, projetoNome);
		configuration.setParallelTesting(testeParalelo);
		configuration.setRunWithJenkins(rodarComJenkins);
		configuration.setBuildNumber(numeroBuild);
		configuration.addClassifications("Plataforma", "Windows");
		configuration.addClassifications("Navegador", "Chrome");
		configuration.addClassifications("Branch", "release/1.0");
		ReportBuilder reportBuilder = new ReportBuilder(arquivosJson, configuration);
		reportBuilder.generateReports();
	}

}
