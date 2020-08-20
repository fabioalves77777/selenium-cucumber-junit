Feature: Filtering

@configuration @done @automated
Scenario: Only selected scenarios are filtered (by tag expression)
	Filtered out scenarios are added (kept) in test suite. See feature "Test Suite Synchronization"
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		@done @current_sprint
		Scenario: Scenario in focus now
			When I do something

		@done
		Scenario: Other scenario
			When I do something
		"""
	And the synchronizer is configured to filter senario tags with "@current_sprint and @done"
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the scenario "Scenario: Scenario in focus now" was synchronized
	But the scenario "Scenario: Other scenario" was not synchronized

