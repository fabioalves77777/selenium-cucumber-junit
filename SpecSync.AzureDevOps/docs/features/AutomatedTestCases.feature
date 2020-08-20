Feature: Automated Test Cases

@done @automated
Scenario: Set test case automation details for synchronized scenarios
	Given there is a VSTS project
	And the synchronizer is configured to enable automation
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then something will happen
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the test case is set to automated
	And the automation details are provided according to the test generated from the scenario

@configuration @done @automated
Scenario: Automation is not synchronized for selected scenarios (by tag list)
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		@manual
		Scenario: Manual scenario
			When I do something
		"""
	And the synchronizer is configured to skip automation for scenario tagged with "@manual,@exploratory"
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario: Manual scenario" is created in the project
	And the test case is not set to automated
	
@configuration @done @automated
Scenario: Automation is not synchronized for selected scenarios (by tag expression)
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		@manual @finished
		Scenario: Manual scenario
			When I do something
		"""
	And the synchronizer is configured to skip automation for scenario tagged with "@exploratory or (@manual and @finished)"
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario: Manual scenario" is created in the project
	And the test case is not set to automated
	
@configuration @done @automated
Scenario: Synchronization of automation can be switched off
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			When I do something
		"""
	And the synchronizer is configured to skip automation
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the test case is not set to automated

@done @automated
Scenario: Set test case automation for scenario outlines
	Note: requires a SpecFlow plugin
	Given there is a VSTS project
	And the synchronizer is configured to enable automation
	And the synchronizer is configured to use "testSuiteBasedExecutionWithScenarioOutlineWrappers" test execution strategy
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario Outline: Sample scenario outline
			Given there is <something>
			When I do <something>
			Then <something> will happen with <someone>
		Examples:
			| something | someone |
			| foo       | Joe     |
			| bar       | Jill    |
			| boz       | Jack    | 
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario Outline: Sample scenario outline" is created in the project
	And the test case is set to automated
	And the automation details are provided according to the test generated from the scenario

@done @automated
Scenario: Associated automation is removed when configuration is changed
	Given there is a VSTS project
	And the synchronizer is configured to enable automation
	And there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then something will happen
		"""
	And the feature file has been synchronized already
	And the synchronizer is configured to skip automation
	When the local workspace is synchronized with push
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the test case is not set to automated

