package br.com.nameproject.support;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;

import org.junit.Assert;

public class Utilitario {

	public static String CaminhoProjeto = System.getProperty("user.dir");
	public static String CaminhoPastaDownload = System.getProperty("user.home") + "\\Downloads";

	public static String retornaDataHora() {
		return new SimpleDateFormat("yyyyMMddhhmmss").format(Calendar.getInstance().getTime());
	}

	public static String retornaDataHoraFormatado() {
		return new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(Calendar.getInstance().getTime());
	}
	
	public static String retornaData() {
		return new SimpleDateFormat("yyyy-MM-dd").format(Calendar.getInstance().getTime());
	}
	
	public static String retornaDataPtBr() {
		return new SimpleDateFormat("dd/MM/yyyy").format(Calendar.getInstance().getTime());
	}
	
	public static String retornaDataAddMonthPtBr(int month) {
		LocalDate localDate = LocalDate.now().plusMonths(month);
        String[] arr = localDate.toString().split("-", 3);
		return arr[2] + "/" + arr[1] + "/" + arr[0];
	}
	
	public static boolean compareDate(String date1, String date2) {
		boolean isValid = false;
		try {
			Date data1 = new SimpleDateFormat("dd/MM/yyyy").parse(date1);
			Date data2 = new SimpleDateFormat("dd/MM/yyyy").parse(date2);
			if(data1.compareTo(data2) > 0) {
				isValid = false;
			} else {
				isValid = true;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}  
		return isValid;
	}

	public static File retornaUltimoArquivoBaixado(String caminhoPasta) {
		File pasta = new File(caminhoPasta);
		File[] arquivos = pasta.listFiles();
		if (arquivos == null || arquivos.length == 0)
			return null;

		File ultimoArquivoModificado = arquivos[0];
		for (int i = 1; i < arquivos.length; i++) {
			if (ultimoArquivoModificado.lastModified() < arquivos[i].lastModified()) {
				ultimoArquivoModificado = arquivos[i];
			}
		}
		return ultimoArquivoModificado;
	}

	public static void verificarDownloadArquivo(String texto) {
		File ultimoArquivo = retornaUltimoArquivoBaixado(CaminhoPastaDownload);
		String nomeArquivo = ultimoArquivo.getName();
		String nomeEsperado = texto;
		if(!nomeArquivo.contains(nomeEsperado)) 
			Assert.fail("Download falhou!");
	}

}
