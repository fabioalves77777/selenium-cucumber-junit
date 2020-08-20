Feature: Test case format

Format options with defaults:
	* "useExpectedResult": false,
    * "syncDataTableAsText": false,
    * "prefixBackgroundSteps": true
	* "prefixTitle": true

Scenario Outline: Prefixing title
	Given there is a VSTS project
	And the synchronizer is configured to use format options as
		| option      | value          |
		| prefixTitle | <option value> |
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			When I do something
		"""
	When SpecSync push is executed
	Then a new test case work item "<expected title>" is created in the project
Examples:
	| case                     | option value | expected title            |
	| title prefixed (default) | true         | Scenario: Sample scenario |
	| title not prefixed       | false        | Sample scenario           |
