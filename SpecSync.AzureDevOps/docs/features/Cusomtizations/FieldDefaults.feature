Feature: Field defaults

Scenario: Should initialize configured fields when linking
	Given there is a VSTS project
	And the synchronizer is configured to use field defaults as
		| field identifier   | value          |
		| System.Description | my description |
	And there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			When I do something
		"""
	When the local workspace is synchronized with push
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the test case fields are set to the following values
		| field identifier   | value          |
		| System.Description | my description |
