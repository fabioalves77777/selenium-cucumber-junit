Feature: Control Test Case Status

@done @automated
Scenario: Test case state is set back to Design when updated
	Given there is a VSTS project
	And the synchronizer is configured to set test case state to 'Design' on change
	And there is a feature file in the local workspace that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Updated sample scenario
			Given there is something new
			When I do something new
			Then something new will happen
		"""
	And the test case state is set to 'Ready'
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case title is updated to "Scenario: Updated sample scenario"
	And the test case state should be 'Design' 
