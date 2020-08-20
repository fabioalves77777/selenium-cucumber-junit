Feature: Force Update

There are different force levels (level 2 is the default):
- 1: force push changes unless the parsed back server version is the same as the local
- 2: force push changes unless all fields are updated to the same
- 3: force push changes in any case

Background: 
	Given there is a VSTS project
	And the synchronizer is configured to force updates
	And the synchronizer is configured to set force update level to 2

Rule: Force update (level 2) should not update unchanged test case
- simple scenarios
- scenarios with data tables
- scenarios with data tables (plain text mode)
- scenarios with doc strings
- scenarios with then steps (use expected result)
- scenarios with background steps (prefixed)
- scenarios with background steps (non-prefixed)
- scenario outlines (examples colum in usage order)
- scenario outlines (examples colum not in usage order)
- scenario outlines (unused examples column)
- scenarios with tags
- scenarios with links
- scenarios with custom field updates

Scenario: Should not update: simple scenarios
	Given there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then there should be something
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Should not update: scenarios with data tables
	Given there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			When I do something with
				| foo | bar |
				| baz | boo |
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Should not update: scenarios with data tables (plain text mode)
	Given the synchronizer is configured to synchronize DataTable as plain text
	And there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			When I do something with
				| foo | bar |
				| baz | boo |
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Should not update: scenarios with doc strings
	Given there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			When I do something with
				```
				foo  bar
				 baz boo
				```
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Should not update: scenarios with then steps (use expected result)
	Given the synchronizer is configured to use ExpectedResult for Then steps
	And there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then there should be something
			And there should be something else too
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Should not update: scenarios with background steps (prefixed)
	Given there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Background: 
			Given there is something in the background

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then there should be something
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Should not update: scenarios with background steps (non-prefixed)
	And the synchronizer is configured to use format options as
		| option                | value |
		| prefixBackgroundSteps | false |
	And there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Background: 
			Given there is something in the background

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then there should be something
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Should not update: scenario outlines (examples colum in usage order)
	Given there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario Outline: Sample scenario
			Given there is <what>
			When <awho> do something
		Examples:
			| what      | awho |
			| something | I    |
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Should not update: scenario outlines (examples colum not in usage order)
	Given there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario Outline: Sample scenario
			Given there is <what>
			When <awho> do something
		Examples:
			| awho | what      |
			| I    | something |
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Should not update: scenario outlines (unused examples column)
	Given there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario Outline: Sample scenario
			Given there is <what>
			When <awho> do something
		Examples:
			| case | awho | what      |
			| me   | I    | something |
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Should not update: scenarios with tags
	Given there is a feature file in the local workspace
		"""
		@foo
		Feature: Sample feature

		@bar @baz
		Scenario: Sample scenario
			Given there is something
			When I do something
			Then there should be something
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed


Scenario: Should not update: scenarios with links
	Given there is a PBI in the VSTS project
	And the synchronizer is configured to synchronize work item links for prefix 'wi'
	And there is a feature file in the local workspace
		"""
		Feature: Sample feature

		@foo @wi:[id-of-pbi]
		Scenario: Sample scenario
			When I do something
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Should not update: scenarios with custom field updates
	Given the synchronizer is configured to use custom field updates as
		| field identifier   | value                               |
		| System.Description | Description: {scenario-description} |
	And there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario: Sample scenario
		This is the description
			When I do something
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed
