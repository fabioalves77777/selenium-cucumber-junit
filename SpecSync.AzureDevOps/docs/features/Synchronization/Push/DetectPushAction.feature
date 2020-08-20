Feature: Detect Push Action

When SpecSync pushes changes to the test case, in addtion to updating the test 
case fields, it also saves the hash of the local state of the scenario. This is 
the scenario-sync-hash. The scenario-sync-hash includes the hash of the core 
scenario details, like name, steps, examples, tags (test-case-hash), and the 
hash of the applied formatting and the custom field update values.

When deciding about whether to update a test case or not, the following values 
are used:
- if it was updated by SpecSync last
- the scenario-sync-hash of the last SpecSync update
- the scenario-sync-hash of the local version
- the test-case-hash of the remote state parsed back from the test case fields

Based on that currently the following cases are detected:
- No change neither locally nor remotely => up-to-date
  - (The test case was last updated by SpecSync and the local 
    scenario-sync-hash is the same)
- A local change was pushed, but it has been reverted, forgotten to check-in or 
  not checked-in yet => outdated with warning
  - (The test case was last updated by SpecSync and the local 
    scenario-sync-hash is the same as the hash of the one before last SpecSync 
	update on remote)
- The scenario was changed locally but not remotely => outdated
  - (The test case was last updated by SpecSync and the local 
    scenario-sync-hash is different)
- The format configuration has been changed => outdated
  - (The test case was last updated by SpecSync and the local 
    scenario-sync-hash is different)
- The test case has been changed remotely, but the changes did not affect the 
  core scenario details => outdated (but won't override anything)
  - (The test case was last updated by the user and the remote test-case-hash 
    is the same as the test-case-hash of the last SpecSync update)
- Both sides has been changed => outdated with warning (SpecSync will override 
  remote change)
  - (The test case was last updated by the user and the remote test-case-hash 
    is different from the test-case-hash of the last SpecSync update.)

Rule: Should detect scenario up-to-date when there is no change neither locally nor remotely

Scenario: Usual scenario was not changed
	Given there is a VSTS project
	And there is a PBI in the VSTS project
	And the synchronizer is configured to synchronize work item links for prefix 'wi'
	And there is a feature file in the local workspace
		"""
		Feature: Sample feature

		@foo @wi:[id-of-pbi]
		Scenario Outline: Sample scenario
			Given there is <what>
				| foo | bar |
				| baz | boo |
			When <awho> do something
				```
				foo  bar
				 baz boo
				```
		Examples:
			| awho | what      |
			| I    | something |
		"""
	And the feature file has been synchronized already
	When the local workspace is synchronized with push
	Then the test case should not be changed

Scenario: Scenario with custom field updates was not changed
	Given there is a VSTS project
	And the synchronizer is configured to use custom field updates as
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

Rule: Should detect scenario outdated when format configuration has been changed

Scenario: Use expected result format configuration has been changed
	Given there is a VSTS project
	And the synchronizer is configured to use format options as
		| option            | value |
		| useExpectedResult | true  |
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
	And the synchronizer is configured to use format options as
		| option            | value |
		| useExpectedResult | false |
	When the local workspace is synchronized with push
	Then the test case should be updated
