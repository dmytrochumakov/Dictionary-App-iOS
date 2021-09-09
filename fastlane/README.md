fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew install fastlane`

# Available Actions
## iOS
### ios unit_tests
```
fastlane ios unit_tests
```
Run Unit Tests
### ios increment_build_num
```
fastlane ios increment_build_num
```
Incrementing Build Number
### ios build_ipa
```
fastlane ios build_ipa
```
Build ipa
### ios distribute
```
fastlane ios distribute
```
Distribute via pilot
### ios release_app_to_testflight
```
fastlane ios release_app_to_testflight
```
Releae App to TestFlight

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
