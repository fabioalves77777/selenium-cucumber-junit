Feature: ListFile Source

Scenario: ListFile Source
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then something will happen
		"""
	And the feature file source is specified as the list of files
	When the local workspace is synchronized with push
	Then the scenario "Scenario: Sample scenario" was synchronized

Scenario: STDIN Source
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then something will happen
		"""
	And the feature file source is specified as the list of files from STDIN
	When the local workspace is synchronized with push
	Then the scenario "Scenario: Sample scenario" was synchronized

