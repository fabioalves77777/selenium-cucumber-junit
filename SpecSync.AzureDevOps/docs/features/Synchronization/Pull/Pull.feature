@pull
Feature: Pull

Pull changes from Azure DevOps server to the local repository.

Scenario: Pull a normal test case to a scenario
	Given there is a VSTS project
	And the synchronizer is configured to enable back syncing
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			When something happens with someone
		"""
	And the feature file has been synchronized already
	When the test case title is updated to 'Scenario: Updated scenario'
	And the SpecSync pull is executed
	Then the feature file in the local workspace should have been updated to contain
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Updated scenario
			When something happens with someone
		"""

Scenario: Steps are synchronized back to feature file
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
		Then this is good for @someone
		"""
	And the SpecSync pull is executed
	Then the feature file in the local workspace should have been updated to contain
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario Outline: Sample scenario outline
			When <something> really happens with <someone>
			Then this is good for <someone>

		Examples:
			| something | someone |
			| foo       | Joe     |
			| bar       | Jill    |
			| boz       | Jack    | 
		"""


Scenario: Parameter values are synchronized back to Scenario Outline
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
	When the test case parameter data is updated to
		| something | someone |
		| one       | Tarzan  |
		| two       | Thomas  |
	And the SpecSync pull is executed
	Then the feature file in the local workspace should have been updated to contain
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario Outline: Sample scenario outline
			When <something> happens with <someone>

		Examples:
			| something | someone |
			| one       | Tarzan  |
			| two       | Thomas  |
		"""


Scenario: Title is synchronized back to feature file
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
	When the test case title is updated to 'Scenario Outline: Updated scenario outline'
	And the SpecSync pull is executed
	Then the feature file in the local workspace should have been updated to contain
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario Outline: Updated scenario outline
			When <something> happens with <someone>

		Examples:
			| something | someone |
			| foo       | Joe     |
			| bar       | Jill    |
			| boz       | Jack    | 
		"""

Scenario Outline: Data Table is synchronized back
	Given there is a VSTS project
	And the synchronizer is configured to enable back syncing
	And the synchronizer is configured to use format options as
		| option              | value                 |
		| syncDataTableAsText | <syncDataTableAsText> |
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			When something happens with someone
				| something | someone |
				| foo       | Joe     |
				| bar       | Jill    |
				| boz       | Jack    | 
			But nothing more
		"""
	And the feature file has been synchronized already
	When the test case title is updated to 'Scenario: Updated scenario'
	And the SpecSync pull is executed
	Then the feature file in the local workspace should have been updated to contain
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Updated scenario
			When something happens with someone
				| something | someone |
				| foo       | Joe     |
				| bar       | Jill    |
				| boz       | Jack    | 
			But nothing more
		"""
Examples: 
	| description                     | syncDataTableAsText |
	| HTML table representation       | false               |
	| Plain-text table representation | true                |

Scenario: Doc String is synchronized back
	Given there is a VSTS project
	And the synchronizer is configured to enable back syncing
	And there is a feature file in the local workspace that was not synchronized yet
		```
		Feature: Sample feature

		Scenario: Sample scenario
			When something happens with someone
				"""
				something, someone
				  somewhere
				"""
			But nothing more
		```
	And the feature file has been synchronized already
	When the test case title is updated to 'Scenario: Updated scenario'
	And the SpecSync pull is executed
	Then the feature file in the local workspace should have been updated to contain
		```
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Updated scenario
			When something happens with someone
				"""
				something, someone
				  somewhere
				"""
			But nothing more
		```
