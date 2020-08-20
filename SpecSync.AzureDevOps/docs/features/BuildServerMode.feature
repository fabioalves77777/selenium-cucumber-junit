Feature: Build Server Mode

On the build server, we might not want to modify local feature
files, as it might not be possible to check them in.
Synchronization of the already linked scenarios should be possible though.

@configuration @done @automated
Scenario: Configure synchronization to only update already synchronized scenarios
	Note: this will not perform local changes, so can better run on server
	Given there is a VSTS project
	And there is a feature file in the local workspace that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Updated sample scenario
			Given there is something new
			When I do something new
			Then something new will happen

		Scenario: Not linked yet
			When I do something
		"""
	And the synchronizer is configured to only update linked test cases
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case title is updated to "Scenario: Updated sample scenario"
	And the feature file in the local workspace is not changed
