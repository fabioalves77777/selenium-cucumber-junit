Feature: Work Item links

Synchronizing special work-item tags (e.g. @us:123) to work item links in test cases

Rules & Examples:

* Establish "Tests" links based on scenario tags
  * there is a @wi:123 tag on the scenario
  * there is a @wi:123 tag on the feature
* adding a work item link should trigger an update
  * only a work item link is added
* Report warning if work item cannot be found
  * the linked work item does not exist (@manual)
  * no rights to access the linked work item (@manual)
  * malformed tag is ignored (@wi:not-a-number) (@manual)
* Multiple prefixes can be linked
  * there are @us:123 and @bug:456 tags
* Links should remain when tag is removed (temporary)
  * the work item tag is removed from the scenario
* Link type can be specified
  * "Tests" link is created by default
  * Linking as "Child"

Questions:

* Do we check the work item type (e.g. linking @us:123, but #123 is a bug)? (Later)
* Shall we remove links when tags removed or if a link was added manually? (Later)
* Shall we back-sync links? (Later)

@automated @done
Scenario: There is a @wi:NNN tag on the scenario
	Given there is a VSTS project
	And there is a PBI in the VSTS project
	And there is a scenario in the local workspace that was already synchronized before
		"""
		@tc:[id-of-test-case] @wi:[id-of-pbi]
		Scenario: Sample scenario
			When I do something
		"""
	And the synchronizer is configured to synchronize work item links for prefix 'wi'
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case is linked to the PBI work item

@automated @done
Scenario: There is a @wi:NNN tag on the feature
	Given there is a VSTS project
	And there is a PBI in the VSTS project
	And there is a feature file in the local workspace that was already synchronized before
		"""
		@wi:[id-of-pbi]
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	And the synchronizer is configured to synchronize work item links for prefix 'wi'
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case is linked to the PBI work item

@automated @done
Scenario: The work item tag is removed from the scenario
	Given there is a VSTS project
	And there is a PBI in the VSTS project
	And the synchronizer is configured to synchronize work item links for prefix 'wi'
	And there is a scenario that was already synchronized before
		"""
		@tc:[id-of-test-case] @wi:[id-of-pbi]
		Scenario: Sample scenario
			When I do something
		"""
	When the scenario is updated to
		"""
		@tc:[id-of-test-case]
		Scenario: Updated sample scenario
			When I do something new
		"""
	And the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case is linked to the PBI work item

@automated @done
Scenario: There are @pbi:NNN and @bug:NNN tags
	Given there is a VSTS project
	And there is a PBI in the VSTS project
	And there is a bug in the VSTS project
	And there is a scenario in the local workspace that was already synchronized before
		"""
		@tc:[id-of-test-case] @pbi:[id-of-pbi] @bug:[id-of-bug]
		Scenario: Sample scenario
			When I do something
		"""
	And the synchronizer is configured to synchronize work item links for prefixes 'pbi, bug'
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case is linked to the PBI work item
	And the test case is linked to the bug work item

@automated @done
Scenario: Only a work item link is added
	Given there is a VSTS project
	And there is a PBI in the VSTS project
	And there is a scenario that was already synchronized before
		"""
		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	And the synchronizer is configured to synchronize work item links for prefix 'wi'
	When the scenario is updated to
		"""
		@tc:[id-of-test-case] @wi:[id-of-pbi]
		Scenario: Sample scenario
			When I do something
		"""
	And the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case is linked to the PBI work item

@automated @done
Scenario: "Tests" link is created by default
	Given there is a VSTS project
	And there is a PBI in the VSTS project
	And there is a scenario in the local workspace that was already synchronized before
		"""
		@tc:[id-of-test-case] @wi:[id-of-pbi]
		Scenario: Sample scenario
			When I do something
		"""
	And the synchronizer is configured to synchronize work item links for prefix 'wi'
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case is linked to the PBI work item as 'Tests'

@automated @done
Scenario: Linking as "Parent"
	Given there is a VSTS project
	And there is a PBI in the VSTS project
	And there is a scenario in the local workspace that was already synchronized before
		"""
		@tc:[id-of-test-case] @wi:[id-of-pbi]
		Scenario: Sample scenario
			When I do something
		"""
	And the synchronizer is configured to synchronize work item links for prefix 'wi/Parent'
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case is linked to the PBI work item as 'Parent'

@automated @done
Scenario: Change link type
	Given there is a VSTS project
	And there is a PBI in the VSTS project
	And there is a scenario in the local workspace that was already synchronized before
		"""
		@tc:[id-of-test-case] @wi:[id-of-pbi]
		Scenario: Sample scenario
			When I do something
		"""
	And the synchronizer is configured to synchronize work item links for prefix 'wi/Tests'
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Given the synchronizer is configured to synchronize work item links for prefix 'wi/Parent'
	And the synchronizer is configured to force updates
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case is linked to the PBI work item as 'Parent'
