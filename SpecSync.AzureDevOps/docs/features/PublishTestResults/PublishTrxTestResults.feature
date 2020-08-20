@publishTestResults
Feature: Publish TRX Test Results

Scenario Outline: Publish a test result
	Given there is a VSTS project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	And there is a test result file with
		| name   | className   | adapterTypeName   | test result name   | outcome |
		| <name> | <className> | <adapterTypeName> | <test result name> | Passed  |
	When the test result is published to configuration "Windows 8"
	Then the command should not fail
	And the there should be a test run registered with test results
		| test case ID      | outcome |
		| [id-of-test-case] | Passed  |
Examples: 
	| description | name                              | className                      | adapterTypeName                     | test result name |
	| SpecRun     | Sample scenario in Sample feature | MyProject.Sample feature       | executor://specrun/executorV3.0.216 | Sample scenario  |
	| MsTest      | SampleScenario                    | MyProject.SampleFeatureFeature | executor://mstestadapter/v2         | SampleScenario   |
	| xUnit       | Sample scenario                   | MyProject.SampleFeatureFeature | executor://xunit/VsTestRunner2/net  | Sample scenario  |
	| NUnit       | SampleScenario                    | MyProject.SampleFeatureFeature | executor://nunit3testexecutor/      | SampleScenario   |
	| NUnit(new)  | Sample scenario                   | MyProject.Sample feature       | executor://nunit3testexecutor/      | SampleScenario   |
Examples: SpecRun special
	| description                | name                                                  | className                                                                                                    | adapterTypeName                     | test result name |
	| with target                | Sample scenario in Sample feature (target: My Target) | MyProject.Sample feature                                                                                     | executor://specrun/executorV3.0.216 | Sample scenario  |
	| corrupt name               | Sample scenario                                       | MyProject.Sample feature                                                                                     | executor://specrun/executorV3.0.216 | Sample scenario  |
	| corrupt name and className | Sample scenario                                       | MyProject.Sample feature.#()::TestAssembly:NetFwSpecFlow24SpecRunProj/Feature:Sample+feature/Scenario:Sample | executor://specrun/executorV3.0.216 | Sample scenario  |

Scenario Outline: Publish Scenario Outline result
	Given there is a VSTS project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario Outline: Sample scenario
			When I do <what>
		Examples:
			| what       |
			| this       |
			| that other |
		"""
	And there is a test result file with
		| name    | className   | adapterTypeName   | test result name     | outcome |
		| <name1> | <className> | <adapterTypeName> | <test result name 1> | Passed  |
		| <name2> | <className> | <adapterTypeName> | <test result name 2> | Failed  |
	When the test result is published to configuration "Windows 8"
	Then the command should not fail
	And the there should be a test run registered with test results
		| test case ID      | outcome |
		| [id-of-test-case] | Failed  |
Examples: 
	| description | adapterTypeName                     | className                      | name1                                                      | test result name 1                                         | name2                                                            | test result name 2                                               |
	| SpecRun     | executor://specrun/executorV3.0.216 | MyProject.Sample feature       | Sample scenario, this in Sample feature                    | Sample scenario, this                                      | Sample scenario, that other in Sample feature                    | Sample scenario, that other                                      |
	| MsTest      | executor://mstestadapter/v2         | MyProject.SampleFeatureFeature | SampleScenario_This                                        | SampleScenario_This                                        | SampleScenario_ThatOther                                         | SampleScenario_ThatOther                                         |
	| xUnit       | executor://xunit/VsTestRunner2/net  | MyProject.SampleFeatureFeature | Sample scenario(result: &quot;this&quot;, exampleTags: []) | Sample scenario(result: &quot;this&quot;, exampleTags: []) | Sample scenario(result: &quot;that other&quot;, exampleTags: []) | Sample scenario(result: &quot;that other&quot;, exampleTags: []) |
	| NUnit       | executor://nunit3testexecutor/      | MyProject.SampleFeatureFeature | SampleScenario(&quot;this&quot;,null)                      | SampleScenario(&quot;this&quot;,null)                      | SampleScenario(&quot;that other&quot;,null)                      | SampleScenario(&quot;that other&quot;,null)                      |
	| NUnit(new)  | executor://nunit3testexecutor/      | MyProject.Sample feature       | Sample scenario(this)                                      | Sample scenario(this)                                      | Sample scenario(that other)                                      | Sample scenario(that other)                                      |
Examples: SpecRun special
	| description                | adapterTypeName                                       | className                                                                                                    | name1                                                       | test result name 1    | name2                                                             | test result name 2          |
	| with target                | executor://specrun/executorV3.0.216                   | MyProject.Sample feature                                                                                     | Sample scenario, this in Sample feature (target: My Target) | Sample scenario, this | Sample scenario, that other in Sample feature (target: My Target) | Sample scenario, that other |
	| corrupt name               | executor://specrun/executorV3.0.216                   | MyProject.Sample feature                                                                                     | Sample scenario, this                                       | Sample scenario, this | Sample scenario, that other                                       | Sample scenario, that other |
	| corrupt name and className | executor://specrun/executorV3.0.216                   | MyProject.Sample feature.#()::TestAssembly:NetFwSpecFlow24SpecRunProj/Feature:Sample+feature/Scenario:Sample | Sample scenario, this                                       | Sample scenario, this | Sample scenario, that other                                       | Sample scenario, that other |

