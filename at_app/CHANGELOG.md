## 4.1.0-rc+1

- Added multiple template support to at_app (the default template is called app)
- Added the ability configure templates, and override certain build configurations
- Introduced two new demo applications (snackbar and snackbar_sender)
- Added 3 flags to create command:
  - ```--list-demos``` - list all demo applications
  - ```--list-templates``` - list all templates
  - ```--list-samples``` - list all samples (currently there are none available but they are coming soon)
- Updated the behaviour of the packages command
- Updated the README.md and usage documentation for at_app

## 4.0.0

- Added desktop support by replacing flutter_config with flutter_dotenv
- Added the --platforms option so you can choose your platforms (web disabled until it's supported by the sdk)
- Added a namespace validator to enforce the usage of a valid @sign
- Fixed the pubspec.yaml file manager to correctly add .env to the assets list

## 3.0.0

- Depends on at_app_flutter 3.0.0
- Updates the android build config for flutter_config (introduced in at_app_flutter 3.0.0)
- Updated the default compileSdkVersion to 31 for android apps
- Performance optimizations to file management

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
