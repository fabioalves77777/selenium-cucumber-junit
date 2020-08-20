Feature: Synchronize DataTable as plain text

@done @automated
Scenario: Synchronize DataTable as plain text
	Given there is a VSTS project
	And the synchronizer is configured to synchronize DataTable as plain text
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Scenario with DataTable
			When I do something with a table
				| foo | bar |
				| boz | boo |
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario: Scenario with DataTable" is created in the project
	And it the first test cases step text contains the following PRE text
		"""
		| foo | bar |
		| boz | boo |
		"""

@automated @done
Scenario: Detects DataTable from plain text steps
	TODO: This is not a proper detection, because we cannot parse back the table from the <pre> tag
	      but since SpecSync detects that the last change was done by us, it does not perform an unneccessary update.
		  This would not be enough for BackSync though...
	Given there is a VSTS project
	And the synchronizer is configured to synchronize DataTable as plain text
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Scenario with DataTable
			When I do something with a table
				| foo | bar |
				| boz | boo |
		"""
	And the feature file has been synchronized already
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case should not be changed

