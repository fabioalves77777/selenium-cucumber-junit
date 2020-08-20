Feature: Custom field updates

Rules:
* Sets fields when linking (test case creation)
* Sets fields when updating (test case update)
* Does not set the fields when scenario is otherwise up-to-date
* Update text can contain the following placeholders
	* {feature-name}
	* {feature-description}
	* {scenario-name}
	* {scenario-description}
	* {br} -- new line

Scenario: Updates custom field when linking
	Given there is a VSTS project
	And the synchronizer is configured to use custom field updates as
		| field identifier   | value                   |
		| System.Description | Feature: {feature-name} |
	And there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			When I do something
		"""
	When the local workspace is synchronized with push
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the test case fields are set to the following values
		| field identifier   | value                   |
		| System.Description | Feature: Sample feature |

Scenario: Updates custom field when updating
	Given there is a VSTS project
	And the synchronizer is configured to use custom field updates as
		| field identifier   | value                   |
		| System.Description | Feature: {feature-name} |
	And there is a feature file in the local workspace
		"""
		Feature: Sample feature

		Scenario: Sample scenario
			When I do something
		"""
	And the feature file has been synchronized already
	When the feature file is updated to
		"""
		Feature: Updated feature

		@tc:[id-of-test-case]
		Scenario: Updated scenario
			When I do something
		"""
	And the local workspace is synchronized with push
	Then the test case title is updated to "Scenario: Updated scenario"
	And the test case fields are set to the following values
		| field identifier   | value                    |
		| System.Description | Feature: Updated feature |

Scenario Outline: Supports different placeholders
	Given there is a VSTS project
	And the synchronizer is configured to use custom field updates as
		| field identifier   | value         |
		| System.Description | <placeholder> |
	And there is a feature file "<feature file path>" in the local workspace
		"""
		Feature: Sample feature
		Feature description

		Scenario: Sample scenario
		Scenario description
			When I do something
		"""
	When the local workspace is synchronized with push
	Then a new test case work item "Scenario: Sample scenario" is created in the project
	And the test case fields are set to the following values
		| field identifier   | value   |
		| System.Description | <value> |
Examples: 
	| placeholder            | value                      | feature file path |
	| {feature-name}         | Sample feature             | MyFeature.feature |
	| {feature-description}  | Feature description        | MyFeature.feature |
	| {scenario-name}        | Sample scenario            | MyFeature.feature |
	| {scenario-description} | Scenario description       | MyFeature.feature |
Examples: path related
	| placeholder           | value                      | feature file path          |
	| {feature-file-name}   | MyFeature.feature          | MyFeature.feature          |
	| {feature-file-folder} |                            | MyFeature.feature          |
	| {feature-file-path}   | MyFeature.feature          | MyFeature.feature          |
	| {feature-file-name}   | MyFeature.feature          | Features\MyFeature.feature |
	| {feature-file-folder} | Features                   | Features\MyFeature.feature |
	| {feature-file-path}   | Features\MyFeature.feature | Features\MyFeature.feature |

Scenario: Updates custom field even if scenario is otherwise up-to-date
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
	When the feature file is updated to
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Sample scenario
		This is the changed description
			When I do something
		"""
	And the local workspace is synchronized with push
	Then the test case fields are set to the following values
		| field identifier   | value                                        |
		| System.Description | Description: This is the changed description |
