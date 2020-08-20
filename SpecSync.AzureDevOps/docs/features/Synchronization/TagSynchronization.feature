Feature: Tag Synchronization

Scenario tags are synchronized as Test Case tags. 

Tags defined on the Feature node are considered for all scenarios within the 
feature.

Rule: Scenario tags are added as Test Case tags

Scenario: A tagged scenario is linked
	Given there is an Azure DevOps project
	And there is a feature file in the local repository
		"""
		@featuretag
		Feature: Sample feature

		@mytag @othertag
		Scenario: Sample scenario
			Given there is something
			When I do something
			Then something will happen
		"""
	When the local repository is synchronized with push
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the new test case has the following tags: "mytag, othertag, featuretag"

Rule: Scenario tags override Test Case tags

Scenario: The tags of the test case are overwritten on push
	Given there is an Azure DevOps project
	And there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case] @mytag
		Scenario: Sample scenario
			When I do something
		"""
	When the test case tags are updated to "mytag, othertag"
	And the local repository is synchronized with push
	Then the scenario "Scenario: Sample scenario" was synchronized
	And the new test case has the following tags: "mytag"
