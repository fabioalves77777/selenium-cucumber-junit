Feature: Failure Recovery

@edge @done @automated
Scenario: Synchronization error if the test case tag refers to a missing test case
	Given there is a VSTS project
	And there is a feature file in the local workspace that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Updated sample scenario
			Given there is something new
			When I do something new
			Then something new will happen
		"""
	And the work item has been destroyed
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the synchronization should finish with errors

@edge @done @automated
Scenario: There is a feature file without any scenario
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Empty feature
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the synchronization should not fail
