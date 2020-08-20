Feature: Tag Text Map Transformation

Provides ability to replace substrings inside tags, e.g.
* "__" => " "
* "=" => "-"

Rule: Should transform tags on push

Scenario: A scenario with a tag containing mapped characters is linked
	Given there is an Azure DevOps project
	And the synchronizer is configured to use tag text map transformation as
		| local | remote |
		| __    | " "    |
		| =     | -      |
	And there is a feature file in the local repository
		"""
		Feature: Sample feature

		@my__tag=value
		Scenario: Sample scenario
			When I do something
		"""
	When the local repository is synchronized with push
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the new test case has the following tags: "my tag-value"

Rule: Should detect scenario as unchanged with transformed tags

Scenario: Scenario with a transformed tag was not changed
	Given there is an Azure DevOps project
	And the synchronizer is configured to use tag text map transformation as
		| local | remote |
		| =     | -      |
	And there is a feature file in the local repository
		"""
		Feature: Sample feature

		@my=tag
		Scenario: Sample scenario
			When I do something
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Rule: Reverse transformation is performed on pull

Scenario: A transformed tag is added to the test case
	Given there is an Azure DevOps project
	And the synchronizer is configured to use tag text map transformation as
		| local | remote |
		| =     | -      |
	And the synchronizer is configured to enable back syncing
	And there is a feature file in the local repository
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			When I do something
		"""
	And the feature file has been synchronized already
	When the test case tags are updated to "my-tag"
	And the SpecSync pull is executed
	Then the feature file in the local workspace should have been updated to contain
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		@my=tag
		Scenario: Sample scenario
			When I do something
		"""