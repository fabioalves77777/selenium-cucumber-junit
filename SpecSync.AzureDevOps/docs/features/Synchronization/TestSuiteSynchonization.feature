Feature: Test Suite Synchonization

SpecSync can keep an ADO static Test Suite with the Test Cases synchronized 
from the scenarios.

Rule: Test Cases synchronized from scenarios should be added to the configured Test Suite

Scenario: Linked test cases are added to the Test Suite
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And there is a feature file in the local repository
		"""
		Feature: My Feature
		Scenario: Scenario 1
			When I do something
		Scenario: Scenario 2
			When I do something
		Scenario: Scenario 3
			When I do something
		"""
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	When the local repository is synchronized with push
	Then the Test Suite should contain the following Test Cases
		| test case            |
		| Scenario: Scenario 1 |
		| Scenario: Scenario 2 |
		| Scenario: Scenario 3 |

Scenario: The Test Suite is specified with ID
	Given there is an Azure DevOps project with an empty Test Suite
	And there is a feature file in the local repository
		"""
		Feature: My Feature
		Scenario: Scenario 1
			When I do something
		"""
	And the synchronizer is configured to add test cases to test suite '#[id-of-test-suite]'
	When the local repository is synchronized with push
	Then the Test Suite should contain the following Test Cases
		| test case            |
		| Scenario: Scenario 1 |


Rule: Test Cases of deleted scenarios should be tagged and removed from the Test Suite

Scenario: The Test Case of a deleted scenario is removed from the Test Suite
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: My Feature

		@tc:[id-of-test-case]
		@sometag
		Scenario: Scenario 1
			When I do something
		"""
	When the feature file is updated to
		"""
		Feature: My Feature

		# Scenario 1 deleted
		"""
	And the local repository is synchronized with push
	Then the test suite should be empty
	And the new test case has the following tags: "sometag, specsync:removed"

Scenario: The removed tag is removed from the Test Case once it is reconnected
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: My Feature

		@tc:[id-of-test-case]
		@sometag
		Scenario: Scenario 1
			When I do something
		"""
	And the feature file was updated and synchronized as
		"""
		Feature: My Feature

		# Scenario 1 deleted
		"""
	When the feature file is updated to
		"""
		Feature: My Feature

		# Scenario 1 restored
		@tc:[id-of-test-case]
		@sometag
		Scenario: Scenario 1
			When I do something
		"""
	And the local repository is synchronized with push
	Then the Test Suite should contain the following Test Cases
		| test case            |
		| Scenario: Scenario 1 |
	And the new test case has the following tags: "sometag"

Rule: Scope changes should be reflected in the Test Suite, while filter changes should not

Scope specifies the set of scenarios that are synchronized to ADO -- if a 
scenario is not in synchronization scope, it will not be added to the Test Suite.

Filtering is a way to temporarily synchronize only a subset of the scenarios --
the Test Suite will contain all scenarios, even if they are currently filtered out.

Scenario: Out-of-scope scenarios are removed from Test Suite
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: My Feature

		@tc:[id-of-test-case]
		@not_done
		Scenario: Scenario 1
			When I do something
		"""
	And the synchronizer is configured to scope scenarios tagged with "@done"
	When the local repository is synchronized with push
	Then the test suite should be empty

Scenario: Filtered out scenarios are not from Test Suite
	Given there is an Azure DevOps project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: My Feature

		@tc:[id-of-test-case]
		@done @not_interesting_now 
		Scenario: Scenario 1
			When I do something
		"""
	And the synchronizer is configured to filter senario tags with "@interesting"
	And the synchronizer is configured to scope scenarios tagged with "@done"
	When the local repository is synchronized with push
	Then the Test Suite should contain the following Test Cases
		| test case            |
		| Scenario: Scenario 1 |

