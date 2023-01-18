## 4.5.1

- **Chore**: Pin `at_app_create` to version `0.3.0`.
- **Chore**: Update atPlatform branding to `at` instead of `@`.

## 4.5.0

- **Chore**: Use `lints: >=1.0.0 <3.0.0` in dev_dependencies.
- **Fix**: Logger color accessibility issues on light mode terminals.
  - Added `chalk: 1.2.0` as a dependency.

## 4.4.0

  - **Chore**: Use `at_app_create: ^0.2.0`.
  - **Chore**: Updated dependencies of all templates to latest.
  - **Fix**(Windows): Explicitly added `biometric_storage: ^4.1.3` as a dependency to all templates.

## 4.3.0

- **Feat**: Added the following sample apps:
  - at_backupkey_flutter
  - at_chat_flutter
  - at_contacts_group_flutter
  - at_events_flutter
  - at_invitation_flutter
  - at_location_flutter
  - at_notify_flutter
  - at_sync_ui_flutter
  - at_theme_flutter
- **Chore**: Use at_app_flutter ^5.0.1 in all app templates.

## 4.2.3

  - **Chore**: Use `at_app_create: ^0.1.1`.

## 4.2.2+1

  - **Chore**: Updated CI badge to refer to the new CI process.

## 4.2.2

  - **Chore**: Migrated some models to [at_app_create](https://pub.dev/packages/at_app_create) package.
    - Developers can now depend on at_app_create to build their own version of at_app.

## 4.2.1

  - **Chore**: Update templates to use [at_app_flutter](https://pub.dev/packages/at_app_flutter) ^5.0.0

## 4.2.0

  - **Chore**: Separated template generation functionality to [at_app_create](https://pub.dev/packages/at_app_create)
  - **Feat**: Added chit_chat demo application
  - **Feat**: Added at_onboarding_flutter and at_contacts_flutter samples

## 4.1.0

- **Feat**: Added multiple template support to at_app (the default template is called app)
- **Feat**: Added the ability configure templates, and override certain build configurations
- **Feat**: Introduced two new demo applications (snackbar and snackbar_sender)
- **Feat**: Added 3 flags to create command:
  - ```--list-demos``` - list all demo applications
  - ```--list-templates``` - list all templates
  - ```--list-samples``` - list all samples (currently there are none available but they are coming soon)
- **Feat**: Added the packages subcommand

## 4.0.0

- **BREAKING CHANGE**: Added desktop support by replacing flutter_config with flutter_dotenv
- **Feat**: Added the --platforms option so you can choose your platforms (web disabled until it's supported by the sdk)
- **Fix**: Added a namespace validator to enforce the usage of a valid @sign
- **Fix**: Fixed the pubspec.yaml file manager to correctly add .env to the assets list

## 3.0.0

- **BREAKING CHANGE**: Depends on `at_app_flutter: ^3.0.0`
- **Chore**: Updated the android build config for flutter_config (introduced in `at_app_flutter ^3.0.0`)
- **Chore**: Updated the default compileSdkVersion to 31 for android apps
- **Chore**: Performance optimizations to file management

## 2.0.0

- **BREAKING CHANGE**: Depends on `at_app_flutter: ^2.0.0`

## 1.1.1

- **Chore**: Depends on `at_app_flutter: ^1.1.1`

## 1.1.0

- **Fix**: at_app now uses .dart_tool/package_config.json to locate the template files contained in at_app_flutter
- **Fix**: Catch errors caused by pub adding to a project that already has the dependency
- **Fix**: at_app now pulls specific dependency versions when generating templates with create
- **Feat**: Added support for multiple templates (hidden flag)

## 1.0.2

- **Feat**: Fallback to check for the templates under the flutter root pub cache

## 1.0.1+1

- **Fix**: Remove bad output when running create command

## 1.0.1

- **Fix**: Bug fixes and clean up of file management

## 1.0.0

- **Chore**: Separated the library portion to it's own package (at_app_flutter).

## 0.1.2

- **Fix**: Fix support for at_app when running via pub global binaries

## 0.1.1

- **Chore**: Documentation changes.

## 0.1.0

- Initial version.
