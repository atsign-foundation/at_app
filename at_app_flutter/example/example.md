# Usage

- [Usage](#usage)
  - [Using AtEnv](#using-atenv)
    - [Loading the environment](#loading-the-environment)
    - [Get the root domain](#get-the-root-domain)
    - [Get the app namespace](#get-the-app-namespace)
    - [Get the at_onboarding_flutter api key](#get-the-at_onboarding_flutter-api-key)
    - [Get the at_onboarding_flutter RootEnvironment](#get-the-at_onboarding_flutter-rootenvironment)

## Using AtEnv

### Loading the environment

```dart
AtEnv.load();
```

In some cases, `AtEnv.load()` can throw an error, which should not be caught.
You must ensure the following:
- The .env file exists (even if it is empty)
- The .env file is listed as a Flutter asset in pubspec.yaml

### Get the root domain

```dart
String rootDomain = AtEnv.rootDomain;
```

[Learn more](https://pub.dev/packages/at_app/example#root-domain) about the root domain.

### Get the app namespace

```dart
String namespace = AtEnv.appNamespace;
```

[Learn more](https://pub.dev/packages/at_app/example#namespace) about the namespace.

### Get the [at_onboarding_flutter](https://pub.dev/packages/at_onboarding_flutter) api key

```dart
String? apiKey = AtEnv.appApiKey;
```

[Learn more](https://pub.dev/packages/at_app/example#api-key) about the api key.

### Get the [at_onboarding_flutter](https://pub.dev/packages/at_onboarding_flutter) RootEnvironment

```dart
var apiKey = AtEnv.rootEnvironment;
```

The rootEnvironment is interpreted by AtEnv depending on whether the api key is available.
If the api key is not null, then AtEnv will return `RootEnvironment.Production`.
If the api key is null, then AtEnv will return `RootEnvironment.Staging`.

*Make sure to include an api key in your .env file, before publishing your app to the store.
