package br.com.nameproject.factories;

import java.io.File;

import br.com.nameproject.support.ReportHelper;

public class ReportFactory {

	static String _pastaHtml = System.getProperty("user.dir") + "\\src\\test\\resources\\report";
	static File _pasta = new File(System.getProperty("user.dir") + "\\src\\test\\resources");
	static String _nomeProjeto = "DemoProject";
	
	public static void main(String[] args) {
		ReportHelper.report(_pastaHtml, _pasta, _nomeProjeto);
	}
}