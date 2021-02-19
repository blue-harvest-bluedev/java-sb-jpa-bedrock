SETLOCAL
@echo .______    __       __    __   _______     __    __       ___      .______      ____    ____  _______      _______..___________.
@echo ^|   _  \  ^|  ^|     ^|  ^|  ^|  ^| ^|   ____^|   ^|  ^|  ^|  ^|     /   \     ^|   _  \     \   \  /   / ^|   ____^|    /       ^|^|           ^|
@echo ^|  ^|_)  ^| ^|  ^|     ^|  ^|  ^|  ^| ^|  ^|__      ^|  ^|__^|  ^|    /  ^^  \    ^|  ^|_)  ^|     \   \/   /  ^|  ^|__      ^|   (----``---^|  ^|----`
@echo ^|   _  ^<  ^|  ^|     ^|  ^|  ^|  ^| ^|   __^|     ^|   __   ^|   /  /_\  \   ^|      /       \      /   ^|   __^|      \   \        ^|  ^|
@echo ^|  ^|_)  ^| ^|  `----.^|  `--   ^| ^|  ^|____    ^|  ^|  ^|  ^|  /  _____  \  ^|  ^|\  \----.   \    /    ^|  ^|____ .----)   ^|       ^|  ^|
@echo ^|______/  ^|_______^| \______/  ^|_______^|   ^|__^|  ^|__^| /__/     \__\ ^| _^| `._____^|    \__/     ^|_______^|^|_______/        ^|__^|
@echo.
@echo Welcome developer!
@echo Please provide the requested input in order to customize the template for your project.
@echo.

@echo First of all, please provide your company name.
@echo Make sure it's all lowercase and separated by dash (-) characters. The default is (blueharvest)
@echo off
set /p COMPANY_NAME="Company name: "
IF "%COMPANY_NAME%"=="" (
    set COMPANY_NAME=blueharvest
)
@echo Great, you work at %COMPANY_NAME%! What a great company!
@echo.

@echo Please provide your team name.
@echo Make sure it's separated by dash (-) characters. The default is (bluedev)
@echo off
set /p TEAM_NAME="Team name: "
IF "%TEAM_NAME%"=="" (
    set TEAM_NAME=bluedev
)
@echo Great Team %TEAM_NAME%!
@echo.

@echo Please provide the name of this (micro)service.
@echo Make sure it's all lowercase and separated by dash (-) characters. The default is (bedrocksb)
@echo off
set /p SERVICE_NAME="Service name: "
IF "%SERVICE_NAME%"=="" (
    set SERVICE_NAME=bedrocksb
)
@echo Great, you'll rock building %SERVICE_NAME%!
@echo.

@echo Alright, ready for the next one?. Please provide the name of your main class.
@echo Make sure it's Capital Case and doesn't contain any special characters or numbers. The default is (BedrockSbApplication)
@echo off
set /p MAIN_CLASS_NAME="Service name: "
IF "%MAIN_CLASS_NAME%"=="" (
    set MAIN_CLASS_NAME=BedrockSbApplication
)
@echo Great, you'll rock building %MAIN_CLASS_NAME%!
@echo.

@echo That's it! Crazy right? You were in the zone as well!
@echo.

@echo Now please give me a few milliseconds to customize your project...
@echo.

set COMPANY_NAME_WITHOUT_DASH=%COMPANY_NAME:-=%
set TEAM_NAME_WITHOUT_DASH=%TEAM_NAME:-=%
set SERVICE_NAME_WITHOUT_DASH=%SERVICE_NAME:-=%
set MAIN_PACKAGE_PATH=com.%COMPANY_NAME_WITHOUT_DASH%.%TEAM_NAME_WITHOUT_DASH%.%SERVICE_NAME_WITHOUT_DASH%"

@echo [INFO] Customizing pom.xml
CALL :replace com.blueharvest.bluedev om.%COMPANY_NAME_WITHOUT_DASH%.%TEAM_NAME_WITHOUT_DASH% pom.xml
CALL :replace blueharvest %COMPANY_NAME% pom.xml
CALL :replace bluedev %TEAM_NAME% pom.xml
CALL :replace bedrocksb %SERVICE_NAME% pom.xml
@echo.

@echo [INFO] Customizing Dockerfile
CALL :replace blueharvest-bluedev %TEAM_NAME% Dockerfile
CALL :replace com.blueharvest.bluedev.bedrocksb.BedrockSbApplication %MAIN_PACKAGE_PATH%.%MAIN_CLASS_NAME% Dockerfile
@echo.

@echo [INFO] Customizing .gitlab-ci.yml
CALL :replace blueharvest %TEAM_NAME% .gitlab-ci.yml
CALL :replace bedrock-service %SERVICE_NAME% .gitlab-ci.yml
@echo.

@echo [INFO] Customizing .\src\main\resources\logback-spring.xml
CALL :replace com.blueharvest.bluedev.bedrocksb %MAIN_PACKAGE_PATH% .src\main\resources\logback-spring.xml
@echo.

@echo [INFO] Refactoring the project packages and directories
for /R %%f in (*.java) do (
    CALL :replace com.blueharvest.bluedev.bedrocksb %MAIN_PACKAGE_PATH% %%f
    CALL :replace BedrockSbApplication %MAIN_CLASS_NAME% %%f
)
git mv .\src\main\java\com\blueharvest\bluedev\bedrocksb\BedrockSbApplication.java .\src\main\java\com\blueharvest\bluedev\bedrocksb\%MAIN_CLASS_NAME%.java
git mv .\src\test\java\com\blueharvest\bluedev\bedrocksb\BedrockSbApplicationTests.java .\src\test\java\com\blueharvest\bluedev\bedrocksb\%MAIN_CLASS_NAME%Tests.java
git mv .\src\main\java\com\blueharvest\bluedev\bedrocksb .\src\main\java\com\blueharvest\bluedev\%SERVICE_NAME_WITHOUT_DASH%
git mv .\src\test\java\com\blueharvest\bluedev\bedrocksb .\src\test\java\com\blueharvest\bluedev\%SERVICE_NAME_WITHOUT_DASH%
git mv .\src\main\java\com\blueharvest\bluedev .\src\main\java\com\blueharvest\%TEAM_NAME_WITHOUT_DASH%
git mv .\src\test\java\com\blueharvest\bluedev .\src\test\java\com\blueharvest\%TEAM_NAME_WITHOUT_DASH%
git mv .\src\main\java\com\blueharvest .\src\main\java\com\%COMPANY_NAME_WITHOUT_DASH%
git mv .\src\test\java\com\blueharvest .\src\test\java\com\%COMPANY_NAME_WITHOUT_DASH%
@echo.

@echo Done! Enjoy your fresh project, happy developing!
@echo And don't forget to pull updates regularly from the bedrock!

EXIT /B 0

:replace
SETLOCAL
set old_value=%1
set new_value=%2
set file=%3
powershell -command "(Get-Content %file%) -replace \"%old_value%\", \"%new_value%\" | Out-File -encoding ASCII %file%"
EXIT /B 0
ENDLOCAL
