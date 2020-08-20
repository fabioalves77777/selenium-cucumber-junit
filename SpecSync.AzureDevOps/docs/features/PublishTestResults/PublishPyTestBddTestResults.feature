Feature: Publish PyTest Bdd Test Results

Scenario: Publish a PyTest Bdd XML Scenario test result
	Given there is a VSTS project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case-1]
		Scenario: Passing scenario
			When it passes

		@tc:[id-of-test-case-2]
		Scenario: Failing scenario
			When it fails
		"""
	And there is a PyTest Bdd XML test result file as
		"""
		<?xml version="1.0" encoding="utf-8"?>
		<testsuites>
		  <testsuite errors="0" failures="1" hostname="mymachine" name="pytest" skipped="0" tests="2" time="0.174" timestamp="2020-06-03T13:33:49.472504">
			<testcase classname="tests.step_defs.test_addition_steps" file="..\..\..\..\appdata\local\programs\python\python38-32\lib\site-packages\pytest_bdd\scenario.py" line="197" name="test_passing_scenario" time="0.003">
			</testcase>
			<testcase classname="tests.step_defs.test_addition_steps" file="..\..\..\..\appdata\local\programs\python\python38-32\lib\site-packages\pytest_bdd\scenario.py" line="197" name="test_failing_scenario" time="0.003">
			  <failure message="assert 24 == 42
		  +24
		  -42">
				request = &lt;FixtureRequest for &lt;Function test_add_two_numbers_failing&gt;&gt;

				@pytest.mark.usefixtures(*function_args)
				def scenario_wrapper(request):
				&gt;       _execute_scenario(feature, scenario, request, encoding)
			  </failure>
			</testcase>
		  </testsuite>
		</testsuites>
		"""
	When the test result is published to configuration "Windows 8"
	Then the command should not fail
	And the there should be a test run registered with test results
		| test case ID        | outcome |
		| [id-of-test-case-1] | Passed  |
		| [id-of-test-case-2] | Failed  |

Scenario: Publish a PyTest Bdd XML Scenario Outline test result
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
	And there is a PyTest Bdd XML test result file as
		"""
		<?xml version="1.0" encoding="utf-8"?>
		<testsuites>
		  <testsuite errors="0" failures="1" hostname="mymachine" name="pytest" skipped="0" tests="2" time="0.174" timestamp="2020-06-03T13:33:49.472504">
			<testcase classname="tests.step_defs.test_addition_steps" file="..\..\..\..\appdata\local\programs\python\python38-32\lib\site-packages\pytest_bdd\scenario.py" line="197" name="test_sample_scenario[something]" time="0.002"></testcase>
			<testcase classname="tests.step_defs.test_addition_steps" file="..\..\..\..\appdata\local\programs\python\python38-32\lib\site-packages\pytest_bdd\scenario.py" line="197" name="test_sample_scenario[something_else]" time="0.001">
			  <failure message="assert 84 == 42
		  +84
		  -42">
				request = &lt;FixtureRequest for &lt;Function test_add_two_numbers_outline[42-42-42]&gt;&gt;
			  </failure>
			</testcase>
		  </testsuite>
		</testsuites>
		"""
	When the test result is published to configuration "Windows 8"
	Then the command should not fail
	And the there should be a test run registered with test results
		| test case ID      | outcome |
		| [id-of-test-case] | Failed  |

Scenario: PyTest Bdd XML contains feature file name as class name
	Given there is a VSTS project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file 'SampleFeature.feature' that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Passing scenario
			When it passes
		"""
	And there is a PyTest Bdd XML test result file as
		"""
		<?xml version="1.0" encoding="utf-8"?>
		<testsuites>
		  <testsuite errors="0" failures="1" hostname="mymachine" name="pytest" skipped="0" tests="2" time="0.174" timestamp="2020-06-03T13:33:49.472504">
			<testcase classname="SampleFeature.feature" file="..\..\..\..\appdata\local\programs\python\python38-32\lib\site-packages\pytest_bdd\scenario.py" line="197" name="test_passing_scenario" time="0.003">
			</testcase>
		  </testsuite>
		</testsuites>
		"""
	When the test result is published to configuration "Windows 8"
	Then the command should not fail
	And the there should be a test run registered with test results
		| test case ID      | outcome |
		| [id-of-test-case] | Passed  |
