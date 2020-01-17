package br.com.nameproject.stepdefinitions.login;

import org.junit.runner.RunWith;

import io.cucumber.junit.Cucumber;
import io.cucumber.junit.CucumberOptions;

@RunWith(Cucumber.class)
@CucumberOptions(
		plugin = { "json:src/test/resources/json/login.json" }, 
		features = "src/test/resources/features", 
		tags = "@LoginDemo", 
		glue = {
				"stepdefinitions/login",
				"support"
				}, 
		monochrome = true, 
		dryRun = false
)
public class Login { }