@REM Excutes the "latest" SypcSync.AzureDevOps version from the NuGet packages folder from the project directory

@pushd %~dp0

@cd /D ..\packages\SpecSync.AzureDevOps.*\tools
@set "TOOLPATH="%cd%\SpecSync4AzureDevOps.exe""

@cd /D %~dp0

%TOOLPATH% %*

@popd