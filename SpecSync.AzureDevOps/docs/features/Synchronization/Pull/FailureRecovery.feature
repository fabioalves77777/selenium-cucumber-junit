@pull
Feature: Pull - Failure Recovery

@edge
Scenario: Invalid Gherkin is synchronized back
	Given there is a VSTS project
	And the synchronizer is configured to enable back syncing
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario Outline: Sample scenario outline
			When <something> happens with <someone>

		Examples:
			| something | someone |
			| foo       | Joe     |
			| bar       | Jill    |
			| boz       | Jack    | 
		"""
	And the feature file has been synchronized already
	When the test case steps are updated to 
		"""
		When @something really happens with @someone
		Invalid this is good for @someone
		"""
	And the SpecSync pull is executed
	Then the synchronization should finish with errors

@edge
Scenario: Strange Gherkin is synchronized back
	Given there is a VSTS project
	And the synchronizer is configured to enable back syncing
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario Outline: Sample scenario outline
			When <something> happens with <someone>

		Examples:
			| something | someone |
			| foo       | Joe     |
			| bar       | Jill    |
			| boz       | Jack    | 
		"""
	And the feature file has been synchronized already
	When the test case title is updated to
		"""
		Scenario: hello
			When hello

		Scenario Outline: Updated scenario outline
		"""
	And the SpecSync pull is executed
	Then the synchronization should finish with errors
