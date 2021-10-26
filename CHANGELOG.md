## 3.0.0-rc+2

- Depends on at_app_flutter 3.0.0
- Updates the android build config for flutter_config which was introduced in at_app_flutter 3.0.0
- Updated the default compileSdkVersion to 31 for android apps
- Performance optimizations to file management
- Modified imports and constant variables for easier maintenance

## 2.0.0

- Uses the new at_app_flutter 2.0.0

## 1.1.1

- Update for bug fix in at_app_flutter

## 1.1.0

- Publish release candidate 1.1.0
- at_app now uses .dart_tool/package_config.json to locate the template files contained in at_app_flutter
- Catch errors caused by pub adding to a project that already has the dependency

## 1.1.0-rc

- at_app now pulls specific dependency versions when generating templates with create
- Added support for multiple templates (hidden flag)

## 1.0.2

- Fallback to check for the templates under the flutter root pub cache

## 1.0.1+1

- Remove bad output when running create command

## 1.0.1

- Bug fixes and clean up of file management

## 1.0.0

- Separated the library portion to it's own package (at_app_flutter).

## 0.1.2+1

- Rename the git repository.

## 0.1.2

- Add support for at_app when using the pub global binaries

## 0.1.1+1

- Fix formatting for README.md

## 0.1.1

- Documentation changes.

## 0.1.0

- Initial version.
