Feature: Publish SpecFlow NUnit XML Test Results

Scenario: Publish a SpecFlow NUnit XML Scenario test result
	Given there is a VSTS project with an empty test suite 'MySuite'
	And the synchronizer is configured to add test cases to test suite 'MySuite'
	And there is a feature file that was already synchronized before
		"""
		Feature: Sample feature

		@tc:[id-of-test-case]
		Scenario: Sample scenario
			When I do something
		"""
	And there is a SpecFlow NUnit XML test result file as
		"""
		<?xml version="1.0" encoding="utf-8" standalone="no"?>
		<test-run id="2" testcasecount="4" result="Failed" total="4" passed="2" failed="2" inconclusive="0" skipped="0" asserts="0" engine-version="3.10.0.0" clr-version="4.0.30319.42000" start-time="2020-02-11 20:20:24Z" end-time="2020-02-11 20:20:27Z" duration="3.209946">
		  <test-suite type="Assembly" id="0-1006" name="MyProject.dll" fullname="MyProject.dll" runstate="Runnable" testcasecount="4" result="Failed" site="Child" start-time="2020-02-11 20:20:26Z" end-time="2020-02-11 20:20:27Z" duration="1.571968" total="4" passed="2" failed="2" warnings="0" inconclusive="0" skipped="0" asserts="0">
			<environment framework-version="3.11.0.0" clr-version="4.0.30319.42000" os-version="Microsoft Windows NT 10.0.18362.0" platform="Win32NT" machine-name="MYMACHINE01" user="myuser" user-domain="MYDOMAIN" culture="en-US" uiculture="en-US" os-architecture="x64" />
			<test-suite type="TestSuite" id="0-1007" name="MyProject" fullname="MyProject" runstate="Runnable" testcasecount="4" result="Failed" site="Child" start-time="2020-02-11 20:20:26Z" end-time="2020-02-11 20:20:27Z" duration="1.529730" total="4" passed="2" failed="2" warnings="0" inconclusive="0" skipped="0" asserts="0">
			  <test-suite type="TestSuite" id="0-1008" name="Features" fullname="MyProject.Features" runstate="Runnable" testcasecount="4" result="Failed" site="Child" start-time="2020-02-11 20:20:26Z" end-time="2020-02-11 20:20:27Z" duration="1.528992" total="4" passed="2" failed="2" warnings="0" inconclusive="0" skipped="0" asserts="0">
				<test-suite type="TestFixture" id="0-1000" name="SampleFeatureFeature" fullname="MyProject.Features.SampleFeatureFeature" classname="MyProject.Features.SampleFeatureFeature" runstate="Runnable" testcasecount="4" result="Failed" site="Child" start-time="2020-02-11 20:20:26Z" end-time="2020-02-11 20:20:27Z" duration="1.523708" total="4" passed="2" failed="2" warnings="0" inconclusive="0" skipped="0" asserts="0">
				  <test-case id="0-1001" name="SampleScenario" fullname="MyProject.Features.SampleFeatureFeature.SampleScenario" methodname="SampleScenario" classname="MyProject.Features.SampleFeatureFeature" runstate="Runnable" seed="182956507" result="Passed" start-time="2020-02-11 20:20:27Z" end-time="2020-02-11 20:20:27Z" duration="0.000522" asserts="0">
					<properties>
					  <property name="Description" value="Sample scenario" />
					</properties>
					<output><![CDATA[Then the scenario should pass
		-> done: Steps.ThenTheScenarioShouldPass() (0.0s)
		]]></output>
				  </test-case>
				</test-suite>
			  </test-suite>
			</test-suite>
		  </test-suite>
		</test-run>		
		"""
	When the test result is published to configuration "Windows 8"
	Then the command should not fail
	And the there should be a test run registered with test results
		| test case ID      | outcome |
		| [id-of-test-case] | Passed  |

Scenario: Publish a SpecFlow NUnit XML Scenario Outline test result
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
	And there is a SpecFlow NUnit XML test result file as
		"""
		<?xml version="1.0" encoding="utf-8" standalone="no"?>
		<test-run id="2" testcasecount="4" result="Failed" total="4" passed="2" failed="2" inconclusive="0" skipped="0" asserts="0" engine-version="3.10.0.0" clr-version="4.0.30319.42000" start-time="2020-02-11 20:20:24Z" end-time="2020-02-11 20:20:27Z" duration="3.209946">
		  <test-suite type="Assembly" id="0-1006" name="MyProject.dll" fullname="MyProject.dll" runstate="Runnable" testcasecount="4" result="Failed" site="Child" start-time="2020-02-11 20:20:26Z" end-time="2020-02-11 20:20:27Z" duration="1.571968" total="4" passed="2" failed="2" warnings="0" inconclusive="0" skipped="0" asserts="0">
			<environment framework-version="3.11.0.0" clr-version="4.0.30319.42000" os-version="Microsoft Windows NT 10.0.18362.0" platform="Win32NT" machine-name="MYMACHINE01" user="myuser" user-domain="MYDOMAIN" culture="en-US" uiculture="en-US" os-architecture="x64" />
			<test-suite type="TestSuite" id="0-1007" name="MyProject" fullname="MyProject" runstate="Runnable" testcasecount="4" result="Failed" site="Child" start-time="2020-02-11 20:20:26Z" end-time="2020-02-11 20:20:27Z" duration="1.529730" total="4" passed="2" failed="2" warnings="0" inconclusive="0" skipped="0" asserts="0">
			  <test-suite type="TestSuite" id="0-1008" name="Features" fullname="MyProject.Features" runstate="Runnable" testcasecount="4" result="Failed" site="Child" start-time="2020-02-11 20:20:26Z" end-time="2020-02-11 20:20:27Z" duration="1.528992" total="4" passed="2" failed="2" warnings="0" inconclusive="0" skipped="0" asserts="0">
				<test-suite type="TestFixture" id="0-1000" name="SampleFeatureFeature" fullname="MyProject.Features.SampleFeatureFeature" classname="MyProject.Features.SampleFeatureFeature" runstate="Runnable" testcasecount="4" result="Failed" site="Child" start-time="2020-02-11 20:20:26Z" end-time="2020-02-11 20:20:27Z" duration="1.523708" total="4" passed="2" failed="2" warnings="0" inconclusive="0" skipped="0" asserts="0">
				  <test-suite type="ParameterizedMethod" id="0-1005" name="SampleScenario" fullname="MyProject.Features.SampleFeatureFeature.SampleScenario" methodname="SampleScenario" classname="MyProject.Features.SampleFeatureFeature" runstate="Runnable" testcasecount="2" result="Passed" site="Child" start-time="2020-02-11 20:20:27Z" end-time="2020-02-11 20:20:27Z" duration="0.490379" total="2" passed="2" failed="0" warnings="0" inconclusive="0" skipped="0" asserts="0">
					<properties>
					  <property name="Description" value="Sample scenario" />
					</properties>
					<test-case id="0-1003" name="SampleScenario(&quot;something&quot;,null)" fullname="MyProject.Features.SampleFeatureFeature.SampleScenario(&quot;something&quot;,null)" methodname="SampleScenario" classname="MyProject.Features.SampleFeatureFeature" runstate="Runnable" seed="2085296631" result="Passed" start-time="2020-02-11 20:20:27Z" end-time="2020-02-11 20:20:27Z" duration="0.240292" asserts="0">
					  <output><![CDATA[Then the scenario should pass
		-> done: Steps.ThenTheScenarioShouldPass() (0.0s)
		]]></output>
					</test-case>
					<test-case id="0-1003" name="SampleScenario(&quot;something else&quot;,null)" fullname="MyProject.Features.SampleFeatureFeature.SampleScenario(&quot;something else&quot;,null)" methodname="SampleScenario" classname="MyProject.Features.SampleFeatureFeature" runstate="Runnable" seed="2085296631" result="Passed" start-time="2020-02-11 20:20:27Z" end-time="2020-02-11 20:20:27Z" duration="0.240292" asserts="0">
					  <output><![CDATA[Then the scenario should pass
		-> done: Steps.ThenTheScenarioShouldPass() (0.0s)
		]]></output>
					</test-case>
				  </test-suite>
				</test-suite>
			  </test-suite>
			</test-suite>
		  </test-suite>
		</test-run>		
		"""
	When the test result is published to configuration "Windows 8"
	Then the command should not fail
	And the there should be a test run registered with test results
		| test case ID      | outcome |
		| [id-of-test-case] | Passed  |
