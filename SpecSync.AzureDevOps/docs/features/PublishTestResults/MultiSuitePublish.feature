@notsupported-tfs2017
Feature: Multi-suite Publish

Background: 
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'

Rule: Test results can be published to additional test suites

Scenario: Results published to another test suite as well
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
	And the following test cases are in suite "SuiteA"
		| test case ID        | 
		| [id-of-test-case-1] | 
	And there is a test result file with
		| name              | className                      | outcome |
		| PassingScenario   | MyProject.SampleFeatureFeature | Passed  |
		| FailingScenario   | MyProject.SampleFeatureFeature | Failed  |
		| MixedResults_Pass | MyProject.SampleFeatureFeature | Passed  |
		| MixedResults_Fail | MyProject.SampleFeatureFeature | Failed  |
	And the publishing is configured to use multi-suite publish as
		| setting    | value             |
		| testPlanId | [id-of-test-plan] |
		| suites     | MySuite,SuiteA    |
	When the test result is published
	Then the command should succeed
	And the there should be a test run registered with test results
		| test case ID        | test suite | outcome |
		| [id-of-test-case-1] | MySuite    | Passed  |
		| [id-of-test-case-2] | MySuite    | Failed  |
		| [id-of-test-case-3] | MySuite    | Failed  |
		| [id-of-test-case-1] | SuiteA     | Passed  |

Scenario: Results published to multiple test suites
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
	And the following test cases are in suite "SuiteA"
		| test case ID        | 
		| [id-of-test-case-1] | 
		| [id-of-test-case-2] | 
	And the following test cases are in suite "SuiteB"
		| test case ID        | 
		| [id-of-test-case-1] | 
	And there is a test result file with
		| name              | className                      | outcome |
		| PassingScenario   | MyProject.SampleFeatureFeature | Passed  |
		| FailingScenario   | MyProject.SampleFeatureFeature | Failed  |
		| MixedResults_Pass | MyProject.SampleFeatureFeature | Passed  |
		| MixedResults_Fail | MyProject.SampleFeatureFeature | Failed  |
	And the publishing is configured to use multi-suite publish as
		| setting    | value             |
		| testPlanId | [id-of-test-plan] |
		| suites     | SuiteA, SuiteB    |
	When the test result is published
	Then the command should succeed
	And the there should be a test run registered with test results
		| test case ID        | test suite | outcome |
		| [id-of-test-case-1] | SuiteA     | Passed  |
		| [id-of-test-case-2] | SuiteA     | Failed  |
		| [id-of-test-case-1] | SuiteB     | Passed  |

Rule: Test results can be published to requirement-based test suites of the linked work items

Scenario: Results published to a requirement-based test suite of a linked PBI and Bug work items
	PBI = product backlog item
	Given there is a Product Backlog Item in the project
	And there is a Bug in the project
	And the synchronizer is configured to synchronize work item links for prefixes 'pbi,bug'
	And there is a requirement-based suite created for the work item '[id-of-pbi]'
	And there is a requirement-based suite created for the work item '[id-of-bug]'
	And there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@pbi:[id-of-pbi] @bug:[id-of-bug]
		@tc:[id-of-test-case-1]
		Scenario: Passing scenario
			When the scenario pass

		@tc:[id-of-test-case-2]
		Scenario: Failing scenario
			When the scenario fail
		"""
	And there is a test result file with
		| name              | className                      | outcome |
		| PassingScenario   | MyProject.SampleFeatureFeature | Passed  |
		| FailingScenario   | MyProject.SampleFeatureFeature | Failed  |
	And the publishing is configured to use multi-suite publish as
		| setting                             | value             |
		| testPlanId                          | [id-of-test-plan] |
		| publishToRequirementBasedTestSuites | true              |
	When the test result is published
	Then the command should succeed
	And the there should be a test run registered with test results
		| test case ID        | test suite                   | outcome |
		| [id-of-test-case-1] | [id-of-pbi] : [title-of-pbi] | Passed  |
		| [id-of-test-case-1] | [id-of-bug] : [title-of-bug] | Passed  |

Rule: The link prefixes for publishing to requirement-based suite can be specified

Scenario: Results published to a requirement-based test suite of selected links
	PBI = product backlog item
	Given there is a Product Backlog Item in the project
	And there is a Bug in the project
	And the synchronizer is configured to synchronize work item links for prefixes 'pbi,bug'
	And there is a requirement-based suite created for the work item '[id-of-pbi]'
	And there is a requirement-based suite created for the work item '[id-of-bug]'
	And there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@pbi:[id-of-pbi] @bug:[id-of-bug]
		@tc:[id-of-test-case-1]
		Scenario: Passing scenario
			When the scenario pass

		@tc:[id-of-test-case-2]
		Scenario: Failing scenario
			When the scenario fail
		"""
	And there is a test result file with
		| name              | className                      | outcome |
		| PassingScenario   | MyProject.SampleFeatureFeature | Passed  |
		| FailingScenario   | MyProject.SampleFeatureFeature | Failed  |
	And the publishing is configured to use multi-suite publish as
		| setting                             | value             |
		| testPlanId                          | [id-of-test-plan] |
		| publishToRequirementBasedTestSuites | true              |
		| LinkTagPrefixes                     | pbi               |
	When the test result is published
	Then the command should succeed
	And the there should be a test run registered with test results
		| test case ID        | test suite                   | outcome |
		| [id-of-test-case-1] | [id-of-pbi] : [title-of-pbi] | Passed  |

Rule: Test results can be published to the sub-suites of the specified suite

Scenario: Results published to a non-specified sub-suite
	Given there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case-1]
		Scenario: Passing scenario
			When the scenario pass

		@tc:[id-of-test-case-2]
		Scenario: Failing scenario
			When the scenario fail
		"""
	And the following test cases are in suite "SuiteA"
		| test case ID        | 
		| [id-of-test-case-1] | 
		| [id-of-test-case-2] | 
	And there is a static suite "SuiteAS" created as a child of "SuiteA"
	And the following test cases are in suite "SuiteAS"
		| test case ID        | 
		| [id-of-test-case-1] | 
	And there is a test result file with
		| name              | className                      | outcome |
		| PassingScenario   | MyProject.SampleFeatureFeature | Passed  |
		| FailingScenario   | MyProject.SampleFeatureFeature | Failed  |
	And the publishing is configured to use multi-suite publish as
		| setting          | value             |
		| testPlanId       | [id-of-test-plan] |
		| suites           | SuiteA            |
		| includeSubSuites | true              |
	When the test result is published
	Then the command should succeed
	And the there should be a test run registered with test results
		| test case ID        | test suite | outcome |
		| [id-of-test-case-1] | SuiteA     | Passed  |
		| [id-of-test-case-2] | SuiteA     | Failed  |
		| [id-of-test-case-1] | SuiteAS    | Passed  |

Rule: Test results can be published to all suites of a test plan

Scenario: Results published to a all sub-suites of the test plan
	Given there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case-1]
		Scenario: Passing scenario
			When the scenario pass

		@tc:[id-of-test-case-2]
		Scenario: Failing scenario
			When the scenario fail
		"""
	And the following test cases are in suite "SuiteA"
		| test case ID        | 
		| [id-of-test-case-1] | 
	And there is a test result file with
		| name              | className                      | outcome |
		| PassingScenario   | MyProject.SampleFeatureFeature | Passed  |
		| FailingScenario   | MyProject.SampleFeatureFeature | Failed  |
	And the publishing is configured to use multi-suite publish as
		| setting            | value             |
		| testPlanId         | [id-of-test-plan] |
		| publishToAllSuites | true              |
	When the test result is published
	Then the command should succeed
	And the there should be a test run registered at least with the test results
		| test case ID        | test suite | outcome |
		| [id-of-test-case-1] | MySuite    | Passed  |
		| [id-of-test-case-2] | MySuite    | Failed  |
		| [id-of-test-case-1] | SuiteA     | Passed  |
