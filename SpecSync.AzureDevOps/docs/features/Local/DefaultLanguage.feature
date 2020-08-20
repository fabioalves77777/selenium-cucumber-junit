Feature: Default language

Rules:

* Supports default language specified in SpecFlow configuration

Scenario: A non English default language is configured in SpecFlow configuration
	Given there is a VSTS project
	And the SpecFlow XML configuration of the project contains
		"""
		<language feature="hu-HU" />
		"""
	And there is a feature file in the local workspace
		"""
		Jellemző: Összeadás

		Forgatókönyv: Két számot összeadok
			Amennyiben összadom a számokat
		"""
	When the local workspace is synchronized with push
	Then the command should succeed

Scenario: A non English default language is configured in SpecSync configuration
	Given there is a VSTS project
	And there is a feature file in the local workspace
		"""
		Jellemző: Összeadás

		Forgatókönyv: Két számot összeadok
			Amennyiben összadom a számokat
		"""
	And the feature file source is specified as the list of files
	And the synchronizer is configured to use default language 'hu-HU'
	When the local workspace is synchronized with push
	Then the command should succeed
