Feature: Publish test results

Background: 
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'

Rule: Should be able to publish test results

Scenario: Results of scenarios and scenario outlines are captured
	Given there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case-1]
		Scenario: Passing scenario
			When the scenario pass

		@tc:[id-of-test-case-2]
		Scenario: Failing scenario
			When the scenario fail

		@tc:[id-of-test-case-3]
		Scenario Outline: Mixed results
			When the scenario <result>
		Examples:
			| result |
			| pass   |
			| fail   |
		"""
	And there is a test result file with
		| name              | className                      | outcome |
		| PassingScenario   | MyProject.SampleFeatureFeature | Passed  |
		| FailingScenario   | MyProject.SampleFeatureFeature | Failed  |
		| MixedResults_Pass | MyProject.SampleFeatureFeature | Passed  |
		| MixedResults_Fail | MyProject.SampleFeatureFeature | Failed  |
	When the test result is published to configuration "Windows 8"
	Then the command should succeed
	And the there should be a test run registered with test results
		| test case ID        | outcome |
		| [id-of-test-case-1] | Passed  |
		| [id-of-test-case-2] | Failed  |
		| [id-of-test-case-3] | Failed  |

Scenario: The test result file is attached to the test run
	Given there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	And there is a test result file "TestResult.trx" with
		| name           | className                      | methodName     | adapterTypeName             | test result name | outcome |
		| SampleScenario | MyProject.SampleFeatureFeature | SampleScenario | executor://mstestadapter/v2 | SampleScenario   | Passed  |
	When the test result is published to configuration "Windows 8"
	Then the command should succeed
	And the there should be a test run registered with attachments
		| file name      | attachment type   | comment  |
		| TestResult.trx | TmiTestRunSummary | TRX File |

Rule: Additional details can be specified for the created Test Run

Scenario: Test run settings are specified
	Given there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	And there is a test result file with
		| name           | className                      | outcome |
		| SampleScenario | MyProject.SampleFeatureFeature | Passed  |
	And the publishing is configured with
		| setting    | value      |
		| runName    | My run     |
		| runComment | My comment |
	When the test result is published to configuration "Windows 8"
	Then the command should succeed
	And the there should be a test run registered with 
		| setting        | value      |
		| Run name       | My run     |
		| Run comment    | My comment |

Scenario: Test result comment is provided
	Given there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case-1]
		Scenario: Sample scenario
			When I do something

		@tc:[id-of-test-case-2]
		Scenario Outline: Mixed results
			When the scenario <result>
		Examples:
			| result |
			| pass   |
			| fail   |
		"""
	And there is a test result file with
		| name              | className                      | outcome |
		| SampleScenario    | MyProject.SampleFeatureFeature | Passed  |
		| MixedResults_Pass | MyProject.SampleFeatureFeature | Passed  |
		| MixedResults_Fail | MyProject.SampleFeatureFeature | Failed  |
	And the publishing is configured with
		| setting           | value      |
		| testResultComment | My comment |
	When the test result is published to configuration "Windows 8"
	Then the command should succeed
	And the there should be a test run registered with test results
		| test case ID        | comment                                                           |
		| [id-of-test-case-1] | My comment                                                        |
		| [id-of-test-case-2] | My comment;<br>MixedResults_Pass: Passed;<br>MixedResults_Fail: Failed |

Rule: The test run can be connected with an Azure DevOps build

Scenario: Build details are specified
	Given there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	And there is a test result file with
		| name           | className                      | outcome |
		| SampleScenario | MyProject.SampleFeatureFeature | Passed  |
	And the publishing is configured with
		| setting       | value                   |
		| buildNumber   | [existing-build-number] |
		| buildPlatform | x86                     |
		| buildFlavor   | Debug                   |
	When the test result is published to configuration "Windows 8"
	Then the command should succeed
	And the there should be a test run registered with 
		| setting        | value               |
		| Build Id       | [existing-build-id] |
		| Build platform | x86                 |
		| Build flavor   | Debug               |

Rule: Inconclusive test result can be mapped

Scenario: Inconclusive is treated as skipped (NotExecuted)
	Given there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario Outline: Mixed results
			When the scenario <result>
		Examples:
			| result       |
			| pass         |
			| inconclusive |
		"""
	And there is a test result file with
		| name                      | className                      | outcome      |
		| MixedResults_Pass         | MyProject.SampleFeatureFeature | Passed       |
		| MixedResults_Inconclusive | MyProject.SampleFeatureFeature | Inconclusive |
	And the publishing is configured with
		| setting             | value       |
		| treatInconclusiveAs | NotExecuted |
	When the test result is published to configuration "Windows 8"
	Then the command should succeed
	And the there should be a test run registered with test results
		| test case ID      | outcome |
		| [id-of-test-case] | Passed  |

