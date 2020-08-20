Feature: Local Repository Scope

The scenarios that are considered for synchronization in the local repository 
can be limited by specifying a local repository scope.

Scenarios that are out of the specified scope are not synchronized and not 
included to the remote Test Suite. (In contrast to filtering that also excludes
scenarios from synchronization, but they are added to the Test Suite.)

Scopes can be specified using:

- tag expressions, see [Tag expressions](TagExpressions.feature)

See also [Filters and scopes](https://specsolutions.gitbook.io/specsync/important-concepts/filters-and-scopes) 
in the documentation.

Rule: Out-of-scope scenarios are not synchronized

Scenario: Only scenarios with specific tag scope are synchronized
	Given there is an Azure DevOps project
	And there is a feature file in the local repository
		"""
		Feature: Sample feature

		@finished @bug:123
		Scenario: Finished scenario
			When I do something
		@manual @finished
		Scenario: Manual scenario
			When I do something
		@ignore
		Scenario: Ignored scenario
			When I do something

		Scenario: Unfinished scenario
			When I do something
		"""
	And the synchronizer is configured to scope scenarios tagged with "@finished and @bug:* and not (@manual or @ignored)"
	When the local repository is synchronized with push
	Then the following scenarios should be processed
		| scenario                      | synchronized |
		| Scenario: Finished scenario   | true         |
		| Scenario: Manual scenario     | false        |
		| Scenario: Ignored scenario    | false        |
		| Scenario: Unfinished scenario | false        |

Rule: Out-of-scope scenarios are not added to Test Suite

Out of scope scenarios are not added (removed) from test suite. See feature "Test Suite Synchronization"

#TODO