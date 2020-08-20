Feature: Test Case Synchronization

@done @automated
Scenario: Link new scenario to a new test case
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			Given there is something
			When I do something
			Then something will happen
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the test case contains the following test steps
		| step                       |
		| Given there is something   |
		| When I do something        |
		| Then something will happen |
	And a tag "@tc:[id-of-new-test-case]" is added to the scenario in the local workspace

@done @automated
Scenario: Link new scenario outline to a new parametrized test case
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario Outline: Sample scenario outline
			Given there is <something>
			When I do <something>
			Then <something> will happen with <someone>
		Examples:
			| something | someone |
			| foo       | Joe     |
			| bar       | Jill    |
			| boz       | Jack    | 
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario Outline: Sample scenario outline" is created in the project
	And the test case contains the following test steps
		| step                                      |
		| Given there is @something                 |
		| When I do @something                      |
		| Then @something will happen with @someone |
	And the test case contains the following parameter data 
		| something | someone |
		| foo       | Joe     |
		| bar       | Jill    |
		| boz       | Jack    | 
	And a tag "@tc:[id-of-new-test-case]" is added to the scenario outline in the local workspace


@done @automated
Scenario: Use scenario outline parameters in data tables
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario Outline: Sample scenario outline
			When I do something with a table
				| foo         | what | bar       |
				| <something> | xxx  | <someone> |
		Examples:
			| something | someone |
			| boz       | Jill    |
			| qux       | Jack    | 
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario Outline: Sample scenario outline" is created in the project
	And it the first test cases step text contains the following HTML table
		| foo        | what | bar      |
		| @something | xxx  | @someone |
	And the test case contains the following parameter data 
		| something | someone |
		| boz       | Jill    |
		| qux       | Jack    | 
	And a tag "@tc:[id-of-new-test-case]" is added to the scenario outline in the local workspace

@done @automated
Scenario: Escape parameters for test case
	SpecSync escapes your scenario text in a way that it should not cause a conflict with MTM parameter syntax
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario Outline: Escaped
			When I do <some thing>that @needs escaping
		Examples:
			| some thing | 
			| foo        | 
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario Outline: Escaped" is created in the project
	And the test case contains the following test steps
		| step                                         |
		| When I do @some-thing that '@'needs escaping |
	And the test case contains the following parameter data 
		| some-thing |
		| foo        |

@done @automated
Scenario: Synchronize changes of an existing scenario to the linked test case
	The link is defined by a test-case tag, e.g. @tc123
	Given there is a VSTS project
	And there is a feature file in the local workspace that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Updated sample scenario
			Given there is something new
			When I do something new
			Then something new will happen
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then the test case title is updated to "Scenario: Updated sample scenario"
	And the test case contains the following test steps
		| step                           |
		| Given there is something new   |
		| When I do something new        |
		| Then something new will happen |
	And the feature file in the local workspace is not changed

@done @automated
Scenario: Include background steps into the test case steps
	Alternative idea: create shared steps
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Background: 
			Given there is something

		Scenario: Sample scenario
			When I do something
			Then something will happen
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the test case contains the following test steps
		| step                                 |
		| Background: Given there is something |
		| When I do something                  |
		| Then something will happen           |


@done @automated
Scenario: Include DataTable step argument in test case step text
	Given there is a VSTS project
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
	And it the first test cases step text contains the following HTML table
		| foo | bar |
		| boz | boo |


@done @automated
Scenario: Include DocString step argument in test case step text
	Alternative idea: save it as an attachment if long
	Given there is a VSTS project
	And there is a feature file in the local workspace that was not synchronized yet
		"""
		Feature: Sample feature

		Scenario: Scenario with DocString
			When I do something with a table
				```
				long text
				with multiple lines
				  and indentation
				```
		"""
	When the SpecFlow2TFS synchronization is executed for the project and the local workspace
	Then a new test case work item "Scenario: Scenario with DocString" is created in the project
	And it the first test cases step text contains the following PRE text
		"""
		long text
		with multiple lines
		  and indentation
		"""
