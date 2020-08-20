package br.com.nameproject.stepdefinitions.cadastro;

import org.junit.runner.RunWith;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(
		plugin = {"json:src/test/resources/json/cadastro.json" }, 
		features = "src/test/resources/features", 
		tags = "@CadastrarUsuario", 
		glue = {
				"br/com/nameproject/stepdefinitions/cadastro",
				"br/com/nameproject/support"
				}, 
		monochrome = true, 
		dryRun = false
)
public class CadastrarUsuarioTest { }