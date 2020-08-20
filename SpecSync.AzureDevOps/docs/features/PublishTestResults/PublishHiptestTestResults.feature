Feature: Publish Hiptest Test Results

Scenario: Publish a Hiptest JSON test result
	Given there is a VSTS project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	And there is a Hiptest JSON test result file as
		"""
		[
		  {
			"uri": "/uri/placeholder",
			"elements": [
			  {
				"steps": [
				  {
					"result": {
					  "duration": 618000,
					  "status": "passed",
					  "error_message": ""
					},
					"name": "I do something",
					"id": "I-do-something",
					"line": 0,
					"keyword": "When "
				  }
				],
				"keyword": "Scenario",
				"type": "scenario",
				"tags": [],
				"name": "Sample scenario (uid:3953dffd-a41a-4391-b2ec-26c7126b31df)",
				"description": "Some description",
				"result": "passed",
				"line": 0
			  }
			],
			"keyword": "Feature",
			"tags": [],
			"name": "Sample feature",
			"id": "sample-feature",
			"result": "passed",
			"line": 0
		  }
		]
		"""
	When the test result is published to configuration "Windows 8"
	Then the command should not fail
	And the there should be a test run registered with test results
		| test case ID      | outcome |
		| [id-of-test-case] | Passed  |