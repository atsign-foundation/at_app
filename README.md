<img src="https://atsign.dev/assets/img/@dev.png?sanitize=true">

### Now for a little internet optimism

# at_app

A command line tool to help developers build an @ platform application.

## Who is this for?

This is for flutter developers looking to build end to end encrypted apps.

## Getting Started

This application is an extension of `flutter create`, that replaces the main.dart file with our own custom template. We also perform the additional build configurations required for the onboarding package.

The at_app toolkit also includes a library component called [at_app_flutter](https://pub.dev/packages/at_app_flutter) which is included with the app built by this executable.

Together these two parts work together to provide app developers with the prerequisites of an @ platform app.

### Executable

The executable is an extension of the `flutter create` command, and can be used to create a new @ platform app from our template.

Activate the executable:

```sh
flutter pub global activate at_app
```

Make sure the pub cache bin is on your path:

```
Windows: %LOCALAPPDATA%/Pub/Cache/bin
Mac/Linux: ~/.pub-cache/bin
```

Create a new @ platform app:

```sh
at_app create [...options] <output directory>
```

Or for windows

```sh
at_app.bat create [...options] <output directory>
```

#### Flags

`at_app create` includes all of the `flutter create` flags, with the exception of --template, --sample, --list-samples

| Flag          | Shorthand | Description                                             | Value                |
| ------------- | --------- | ------------------------------------------------------- | -------------------- |
| --namespace   | -n        | The @protocol app namespace to use for the application. | (defaults to "")     |
| --root-domain | -r        | The @protocol root domain to use for the application.   | [prod (default), ve] |
| --api-key     | -k        | The api key for at_onboarding_flutter.                  | (defaults to "")     |

### Library

Please see [at_app_flutter](https://pub.dev/packages/at_app_flutter) for library usage within your generated app.

## Maintainers

Created by [XavierChanth](https://github.com/xavierchanth)
