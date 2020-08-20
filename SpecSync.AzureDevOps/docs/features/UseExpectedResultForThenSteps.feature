Feature: Use ExpectedResult for Then steps

@done @automated
Scenario: Use ExpectedResult for Then steps
	Given there is a VSTS project
	And the synchronizer is configured to use ExpectedResult for Then steps
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then something will happen
			And something else too
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the test case contains the following test steps
		| step                     | expected result            |
		| Given there is something |                            |
		| When I do something      | Then something will happen |
		|                          | And something else too     |

@automated @done
Scenario: Detects steps in the ExpectedResult
	Given there is a VSTS project
	And the synchronizer is configured to use ExpectedResult for Then steps
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then something will happen
			And something else too
		"""
	And the feature file has been synchronized already
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case should not be changed

