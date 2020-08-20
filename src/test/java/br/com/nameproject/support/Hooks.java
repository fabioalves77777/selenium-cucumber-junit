package br.com.nameproject.support;

import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;

import br.com.nameproject.factories.DriverFactory;
//import br.com.nameproject.factories.VideoFactory;
import br.com.nameproject.models.ConfiguracaoAmbiente;
import io.cucumber.core.api.Scenario;
import io.cucumber.java.After;
import io.cucumber.java.AfterStep;
import io.cucumber.java.Before;
import io.cucumber.java.BeforeStep;

public class Hooks {
	
	public ConfiguracaoAmbiente _configuracao;
	public DriverFactory _driver;
	//VideoFactory _videoReord = new VideoFactory(); 
	
	@Before
	public void initialize(Scenario cenario) throws Exception {	
		_configuracao = new ConfiguracaoAmbiente();
		_driver = new DriverFactory(_configuracao);
		//_videoReord.startRecording(cenario.getName());
		System.out.println("Before: Initialize Feature");
	}
	
	@BeforeStep
	public void beforeStepDefinition() {
		System.out.println("Before Step: Execute Before Step");
	}
		
	@AfterStep
	public void afterStepDefinition(Scenario cenario) {
		final byte[] screenshot = ((TakesScreenshot) _driver.driver()).getScreenshotAs(OutputType.BYTES);
		cenario.embed(screenshot, "image/png");		
		System.out.println("After Step: Execute After Step");
	}
	
	@After
	public void tearDown(Scenario cenario) throws Exception {
		//_videoReord.stopRecording();
		final byte[] screenshot = ((TakesScreenshot) _driver.driver()).getScreenshotAs(OutputType.BYTES);
		cenario.embed(screenshot, "image/png");	
		_driver.fecharNavegador();			
		System.out.println("After: Finalize Feature");
	}

}
