## 4.2.1
  - **CHORE**: Update templates to use [at_app_flutter](pub.dev/packages/at_app_flutter) 5.0.0

## 4.2.0

  - **CHORE**: Separated template generation functionality to [at_template](pub.dev/packages/at_template)
  - **FEAT**: Added chit_chat demo application
  - **FEAT**: Added at_onboarding_flutter and at_contacts_flutter samples

## 4.1.0

- **FEAT**: Added multiple template support to at_app (the default template is called app)
- **FEAT**: Added the ability configure templates, and override certain build configurations
- **FEAT**: Introduced two new demo applications (snackbar and snackbar_sender)
- **FEAT**: Added 3 flags to create command:
  - ```--list-demos``` - list all demo applications
  - ```--list-templates``` - list all templates
  - ```--list-samples``` - list all samples (currently there are none available but they are coming soon)
- **FEAT**: Added the packages subcommand

## 4.0.0

- **BREAKING CHANGE**: Added desktop support by replacing flutter_config with flutter_dotenv
- **FEAT**: Added the --platforms option so you can choose your platforms (web disabled until it's supported by the sdk)
- **FIX**: Added a namespace validator to enforce the usage of a valid @sign
- **FIX**: Fixed the pubspec.yaml file manager to correctly add .env to the assets list

## 3.0.0

- **BREAKING CHANGE**: Depends on at_app_flutter 3.0.0
- **CHORE**: Updated the android build config for flutter_config (introduced in at_app_flutter 3.0.0)
- **CHORE**: Updated the default compileSdkVersion to 31 for android apps
- **CHORE**: Performance optimizations to file management

## 2.0.0

- **BREAKING CHANGE**: Depends on at_app_flutter 2.0.0

## 1.1.1

- **CHORE**: Depends on at_app_flutter 1.1.1

## 1.1.0

- **FIX**: at_app now uses .dart_tool/package_config.json to locate the template files contained in at_app_flutter
- **FIX**: Catch errors caused by pub adding to a project that already has the dependency
- **FIX**: at_app now pulls specific dependency versions when generating templates with create
- **FEAT**: Added support for multiple templates (hidden flag)

## 1.0.2

- **FEAT**: Fallback to check for the templates under the flutter root pub cache

## 1.0.1+1

- **FIX**: Remove bad output when running create command

## 1.0.1

- **FIX**: Bug fixes and clean up of file management

## 1.0.0

- **CHORE**: Separated the library portion to it's own package (at_app_flutter).

## 0.1.2

- **FIX**: Fix support for at_app when running via pub global binaries

## 0.1.1

- **CHORE**: Documentation changes.

## 0.1.0

- Initial version.
