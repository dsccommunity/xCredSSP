# Changelog for xCredSSP

The format is based on and uses the types of changes according to [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- xCredSSP
  - Renamed default branch to `main`.

## [1.4.0] - 2022-10-23

- Updated pipeline for continuos delivery.
- Fixed issue where the Set method did not correct DelegateComputers, when
  two machines were accidentally added as one string instead of an array.

## [1.3.0] - 2017-05-31

- Added a fix to enable credSSP with a fresh server installation

## [1.2.0] - 2017-03-24

- Converted appveyor.yml to install Pester from PSGallery instead of from Chocolatey.
- Implemented a GPO check to prevent an endless reboot loop when CredSSP is
  configured via a GPO
- Fixed issue with Test always returning false with other regional settings
  then english
- Added check to test if Role=Server and DelegateComputers parameter is specified
- Added parameter to supress a reboot, default value is false (reboot server
  when required)

## [1.1.0] - 2016-03-31

- Made sure DSC reboots if credSS is enabled

## [1.0.1] - 2014-10-24

- Updated with minor bug fixes.

## [1.0.0] - 2014-09-27

- Initial release with the following resources:
  - xCredSSP
