# Robot Framework + Appium — Android cart

[Versão em português](README.md)

Five UiAutomator2 scenarios against Sauce Labs' official [My Demo App 2.3.0 APK](https://github.com/saucelabs/my-demo-app-android/releases/tag/2.3.0). `Clients` selects tests, `TestCases` composes flows, `Pages` holds locators and `Resources` manages sessions, following my existing Robot projects.

## Scenarios

- Increase/decrease quantity and verify item count and total.
- Remove the final item and check that checkout is unavailable.
- Keep cart state when returning from the background.
- Disable addition at zero quantity and re-enable it at a positive quantity.
- Restart the process and verify an empty cart in the new session.

The last behavior is an application limitation: cart state lives in an in-memory singleton. Background/resume and process restart have different contracts. See `SingletonClass` in the [versioned source](https://github.com/saucelabs/my-demo-app-android/tree/3e514167ec715abf6ab93e148ef6f97b86752c05).

## Run

Use Python 3.13, Node 24, Java 21, Android SDK and an Android 34 emulator. From the repository root:

```bash
cp .env.example .env
python -m venv .venv
```

Activate with `.venv\Scripts\activate` on Windows or `source .venv/bin/activate` on Linux, then:

```bash
python -m pip install -r requirements.txt
npm ci
npx appium driver list --installed
```

UiAutomator2 is installed by `npm ci` from the lockfile. The command above confirms the driver; a second installation is unnecessary.

PowerShell uses `Copy-Item .env.example .env`. Download the official APK to `APP_PATH` and set `ANDROID_DEVICE` from `adb devices`. Start `npm run appium` in one terminal, then:

```bash
python run_tests.py --outputdir results --xunit junit.xml src/Appium/Clients
```

Appium binds only to localhost. Each test clears application data in a new session. No private credentials or paid services are required.

## Results and limits

[Actions](https://github.com/brunobaccari/robot-appium-android-cart/actions) runs all five cases on an emulator. The summary lists results; `android-results` contains JUnit, Robot HTML log/report, available screenshots and server logs for 14 days. Generated outputs are ignored by Git.

Incorrect totals/state, skipped cases or missing JUnit fail the run. Inspect the original failed keyword and screenshot before changing expectations. No automatic rerun-until-green. `--dryrun` checks structure only.

Android only, one emulator and the pinned official APK. No iOS, physical-device, real-payment or complete-coverage claim. The npm audit on 2026-10-06 reported 12 affected dependencies (7 critical, 4 high and 1 moderate) in the tooling. Some are bundled inside UiAutomator2 or pinned by Appium; the version changes suggested by `npm audit fix --force` were not applied. A compatible update and another execution remain pending. The server only listens on localhost; restricting access does not fix those vulnerabilities.

The Actions summary lists every scenario, duration, totals and blocking reason. The gate requires the count configured in the workflow, with no failures or skips; missing or invalid JUnit fails the gate. The summary is also included in the artifact.
