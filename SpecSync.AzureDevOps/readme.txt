SpecSync for Azure DevOps
============================================
by Spec Solutions (https://specsolutions.eu)

SpecSync for Azure DevOps is a synchronization tool thatsynchronizes Gherkin 
feature files with Azure DevOps (Microsoft Team Foundation Server, TFS; 
Visual Studio Team Services, VSTS; Microsoft Test Manager, MTM).

This package contains the synchronization tool that can be used to process 
Gherkin feature files of any BDD tool, like Cucumber or SpecFlow.

For detailed introduction, usage and lincensing, please check out the project 
site at http://speclink.me/specsync or the documentation at 
http://speclink.me/specsyncdoc.

There is a detailed Getting Started guide at 
http://speclink.me/specsyncgettingstarted.

See configuration options and samples at http://speclink.me/specsyncconfig. You 
can also check the 'specsync-sample.json' file in the 'docs' folder of the 
NuGet package.

Please send your questions or license inquiries to specsync@specsolutions.eu.

Note for SpecFlow users: In order to synchronized test cases that can be 
executed by Azure DevOps (automated test cases), you also need to install the 
SpecSync.AzureDevops.SpecFlow.X-Y NuGet package, where X-Y is the SpecFlow 
version to be used for (e.g. SpecSync.AzureDevops.SpecFlow.2-3 for 
SpecFlow v2.3.*. Further details and limitations for synchronizing automated 
test cases can be found at http://speclink.me/specsyncautomatedtc.

Note: SpecSync collects anonymous error diagnostics and statistics. No user or 
machine names, Azure DevOps urls, test case or test suite names or IDs are 
collected! This can be disabled with the "--disableStats" parameter.
