*** Settings ***
Library    AppiumLibrary    timeout=30    run_on_failure=Capture Page Screenshot
Library    OperatingSystem

*** Keywords ***
Open Demo App
    ${app}=    Normalize Path    ${EXECDIR}/%{APP_PATH}
    File Should Exist    ${app}
    Open Application    %{APPIUM_URL}
    ...    platformName=Android
    ...    appium:automationName=UiAutomator2
    ...    appium:udid=%{ANDROID_DEVICE}
    ...    appium:app=${app}
    ...    appium:appPackage=%{APP_PACKAGE}
    ...    appium:appActivity=com.saucelabs.mydemoapp.android.view.activities.SplashActivity
    ...    appium:appWaitActivity=com.saucelabs.mydemoapp.android.view.activities.MainActivity
    ...    appium:noReset=${False}
    ...    appium:autoGrantPermissions=${True}
    ...    appium:newCommandTimeout=120
    Wait Until Page Contains Element    id=%{APP_PACKAGE}:id/productIV    60s

Close Demo App
    Close All Applications
