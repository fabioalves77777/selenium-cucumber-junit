Feature: Area and Iteration

@automated @done
Scenario: Create new test case in a specified area path
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then something will happen
		"""
	And the synchronizer is configured to create work items in area '\TestArea'
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the new test case is in the following area: '\TestArea'

@automated @done
Scenario: Test case created in the root area by default
	Given there is a VSTS project
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
	And the new test case is in the following area: '\'

@automated @done
Scenario: Test case created in the root iteration by default
	Given there is a VSTS project
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
	And the new test case is in the following iteration: '\'

@automated @done
Scenario: Create new test case in a specified iteration path
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then something will happen
		"""
	And the synchronizer is configured to create work items in iteration '\TestIteration'
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the new test case is in the following iteration: '\TestIteration'
