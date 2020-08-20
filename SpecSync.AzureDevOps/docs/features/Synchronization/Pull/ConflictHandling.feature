@pull
Feature: Pull - Conflict handling

Scenario: Both the test case and the scenario were changed (conflict)
	Given there is a VSTS project
	And the synchronizer is configured to enable back syncing
	And there is a scenario that was already synchronized before
		"""
		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	When the test case title is updated to 'Scenario: Updated scenario on remote'
	When the scenario is updated to
		"""
		@tc:[id-of-test-case]
		Scenario: Updated scenario on local
			When I do something new
		"""
	And the SpecSync pull is executed with chosing "Remote" for conflict
	Then the feature file in the local workspace should have been updated to contain
		"""
		Feature: Sample feature
		@tc:[id-of-test-case]
		Scenario: Updated scenario on remote
			When I do something
		"""

Scenario: Quit from conflict
	Given there is a VSTS project
	And the synchronizer is configured to enable back syncing
	And there is a scenario that was already synchronized before
		"""
		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	When the test case title is updated to 'Scenario: Updated scenario on remote'
	When the scenario is updated to
		"""
		@tc:[id-of-test-case]
		Scenario: Updated scenario on local
			When I do something new
		"""
	And the SpecSync pull is executed with chosing "Quit" for conflict
	Then the synchronization should finish with errors


Scenario: Skip from conflict
	Given there is a VSTS project
	And the synchronizer is configured to enable back syncing
	And there is a scenario that was already synchronized before
		"""
		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	When the test case title is updated to 'Scenario: Updated scenario on remote'
	When the scenario is updated to
		"""
		@tc:[id-of-test-case]
		Scenario: Updated scenario on local
			When I do something new
		"""
	And the SpecSync pull is executed with chosing "Skip" for conflict
	Then the synchronization should not fail
