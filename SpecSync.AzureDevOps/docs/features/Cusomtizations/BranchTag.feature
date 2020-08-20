Feature: Branch tag

Rules:
- Add branch-tag for an existing scenario if changed
	- Branch-tag is added to an unlinked scenario
	- Branch-tag is added to a linked scenario when changed
	- Scenario without branch-tag is unchanged if the test case is up-to-date
- Update branch-tagged test case if exists
	- Update test case identified by the branch-tag when updated
- Executing Scenario Outline uses the examples from the branch test case
	- TODO: A data-driven branch test case automation is executed with changed examples

@done @automated
Scenario: Branch-tag is added to an unlinked scenario
	rule: Add branch-tag for an existing scenario if changed
	Given there is a VSTS project
	And the synchronizer is configured to use branch-tag prefix "tc.mybranch"
	And there is a scenario in the local workspace that was not synchronized yet
		"""
		Scenario: Sample scenario
			When I do something
		"""
	When the local workspace is synchronized with push
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the test case contains the following test steps
		| step                |
		| When I do something |
	And a tag "@tc.mybranch:[id-of-new-test-case]" is added to the scenario in the local workspace

@done @automated
Scenario: Branch-tag is added to a linked scenario when changed
	rule: Add branch-tag for an existing scenario if changed
	Given there is a VSTS project
	And there is a scenario that was already synchronized before
		"""
		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	And the synchronizer is configured to use branch-tag prefix "tc.mybranch"
	When the scenario is updated to
		"""
		@tc:[id-of-test-case]
		Scenario: UPDATED scenario
			When I do something NEW
		"""
	And the local workspace is synchronized with push
	Then a new test case work item "Scenario: UPDATED scenario" is created in the project
	And the test case contains the following test steps
		| step                    |
		| When I do something NEW |
	And a tag "@tc.mybranch:[id-of-new-test-case]" is added to the scenario in the local workspace

@done @automated
Scenario: Scenario without branch-tag is unchanged if the test case is up-to-date
	rule: Add branch-tag for an existing scenario if changed
	Given there is a VSTS project
	And there is a scenario that was already synchronized before
		"""
		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	And the synchronizer is configured to use branch-tag prefix "tc.mybranch"
	When the local workspace is synchronized with push
	Then the test case should not be changed
	And the feature file in the local workspace is not changed

@done @automated
Scenario: Update test case identified by the branch-tag when updated
	rule: Update branch-tagged test case if exists
	Given there is a VSTS project
	And the synchronizer is configured to use branch-tag prefix "tc.mybranch"
	And there is a scenario that was already synchronized before on a branch
		"""
		@tc:[id-of-trunk-test-case] @tc.mybranch:[id-of-test-case]
		Scenario: Sample scenario modified on a branch
			When I do something
		"""
	When the scenario is updated to
		"""
		@tc:[id-of-trunk-test-case] @tc.mybranch:[id-of-test-case]
		Scenario: UPDATED scenario modified on a branch
			When I do something NEW
		"""
	And the local workspace is synchronized with push
	Then the test case title is updated to "Scenario: UPDATED scenario modified on a branch"
	And the feature file in the local workspace is not changed