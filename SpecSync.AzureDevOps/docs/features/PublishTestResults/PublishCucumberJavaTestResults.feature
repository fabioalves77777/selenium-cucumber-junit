Feature: Publish Cucumber Java Test Results

Scenario: Publish a Cucumber Java JUnit XML Scenario test result
	Given there is a VSTS project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	And there is a Cucumber Java JUnit XML test result file as
		"""
		<testsuite errors="0" failures="0" hostname="mymachine" name="Sample feature" skipped="0" tests="1" time="0.537205" timestamp="2019-11-08T09:10:24.750967">
		  <testcase classname="Sample feature" name="Sample scenario" status="passed" time="0.515184" />
		</testsuite>		
		"""
	When the test result is published to configuration "Windows 8"
	Then the command should not fail
	And the there should be a test run registered with test results
		| test case ID      | outcome |
		| [id-of-test-case] | Passed  |

Scenario: Publish a Cucumber Java JUnit XML Scenario Outline test result
	Given there is a VSTS project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario Outline: Sample scenario
			When I do <what>
		Examples:
			| what           |
			| something      |
			| something else |
		"""
	And there is a Cucumber Java JUnit XML test result file as
		"""
		<testsuite errors="0" failures="0" hostname="mymachine" name="Sample feature" skipped="0" tests="1" time="0.537205" timestamp="2019-11-08T09:10:24.750967">
		  <testcase classname="Sample feature" name="Sample scenario" status="passed" time="0.1" />
		  <testcase classname="Sample feature" name="Sample scenario" status="passed" time="0.2" />
		</testsuite>		
		"""
	When the test result is published to configuration "Windows 8"
	Then the command should not fail
	And the there should be a test run registered with test results
		| test case ID      | outcome |
		| [id-of-test-case] | Passed  |
