# Usage

The following provides a full guide on the various ways to use at_app.

## Table of Contents
- [Usage](#usage)
  - [Table of Contents](#table-of-contents)
  - [Installing and Updating](#installing-and-updating)
  - [Windows Users](#windows-users)
  - [Creating an @platform app](#creating-an-platform-app)
    - [Explore and use other templates](#explore-and-use-other-templates)
    - [Explore and try a package sample](#explore-and-try-a-package-sample)
    - [Explore and try a demo app](#explore-and-try-a-demo-app)
    - [App Configuration](#app-configuration)
      - [@platform Configuration](#platform-configuration)
        - [namespace](#namespace)
        - [root-domain](#root-domain)
        - [api-key](#api-key)
      - [Flutter Configuration](#flutter-configuration)
  - [Working with @platform Packages](#working-with-platform-packages)
    - [Discovering @platform Packages](#discovering-platform-packages)
    - [Adding packages](#adding-packages)

## Installing and Updating

Activate the latest version of at_app using pub:

```sh
flutter pub global activate at_app
```

Or specify a specific version:

```sh
flutter pub global activate at_app <version>
```

*Additionally, pub may prompt you to add the global bin to your PATH variable, please do so before proceeding.

## Windows Users

Pub binaries are activated as batch files on Windows.

If you are a Windows user, replace `at_app` with `at_app.bat` in the following commands.

## Creating an @platform app

The default template generates a starter @platform application.  
The basic command syntax is identical to `flutter create`:

```sh
at_app create <path/to/output/directory>
```

### Explore and use other templates

As we add more templates to at_app, they will be visible using the `--list-templates` flag:

```sh
at_app create --list-templates
```

You can specify a template in the same way as flutter create:

```sh
at_app create --template <template-name> <path/to/output/directory>
```

Alternatively, use the `-t` abbreviation:

```sh
at_app create -t <template-name> <path/to/output/directory>
```

### Explore and try a package sample

Similar to our templates, we also provide samples of our packages.  
View them using the `--list-samples` flag:

```sh
at_app create --list-samples
```

Our samples are different than `flutter create` they act similar to the templates.  
You can specify a sample using the `--sample` option:

```sh
at_app create --sample <sample-name> <path/to/output/directory>
```

Alternatively, use the `-s` abbreviation:

```sh
at_app create -s <sample-name> <path/to/output/directory>
```

### Explore and try a demo app

Similar to our templates and samples, we also provide full demo apps that you can try.  
View them using the `--list-demos` flag:

```sh
at_app create --list-demos
```

Our demo apps can be specified using `--demo` similar to the templates and samples:

```sh
at_app create --demo <demo-name> <path/to/output/directory>
```

Alternatively, use the `-d` abbreviation:

```sh
at_app create -d <demo-name> <path/to/output/directory>
```
### App Configuration

Just like `flutter create`, at_app also ships with a number of commands to
configure your application to suit your needs. Some of these options are
inherited from flutter create, and others are specific to @platform apps.

#### @platform Configuration

| Option        | Shorthand | Description                                             | Value        |
| ------------- | --------- | ------------------------------------------------------- | ------------ |
| --namespace   | -n        | The @protocol app namespace to use for the application. | atsign       |
| --root-domain | -r        | The @protocol root domain to use for the application.   | [prod \| ve] |
| --api-key     | -k        | The api key used by at_onboarding_flutter               | api-key      |

These arguments are loaded into a .env file in the application and read into the app by [at_app_flutter](https://pub.dev/packages/at_app_flutter). If some or all of these arguments are left unspecified, at_app_flutter will use its fallback values.

##### namespace

In short, the namespace is what distinguishes the data stored by your app from other apps on the @platform.
To ensure that you are not colliding with other namespaces, the best practice is to use an atsign that you own.
By convention, if you own the atsign, then you also own the namespace. [Learn more](). <!-- TODO add link to atsign.dev page -- >

Example usage:

```sh
at_app create --namespace @alice <path/to/output/directory>
```

Or the shorthand:

```sh
at_app create -n @alice <path/to/output/directory>
```

##### root-domain

In most cases, the root-domain is fine when left on the default option (prod a.k.a. production).
The production environment allows you to test your app, using regular atsigns.
It is recommended to get and activate some free atsigns for testing purposes.

The alternative option available is ve, which stands for virtual environment.
The virtual environment is a self-contained docker development environment for developing on the @platform.
While ve is still available, using prod is preferred.

No additional options are required if you want to use production, however, if you want to use ve:

```sh
at_app create --root-domain ve <path/to/output/directory>
```

Or the shorthand:

```sh
at_app create -r ve <path/to/output/directory>
```

##### api-key

The api-key is used by the at_onboarding_flutter package to provide app users with an easy way to get a free atsign within the application. See [here](https://pub.dev/packages/at_onboarding_flutter#api-key) for how to get your api-key.

Adding it to the app is very straight forward:

```sh
at_app create --api-key <api-key> <path/to/output/directory>
```

Or the shorthand:

```sh
at_app create -k <api-key> <path/to/output/directory>
```

#### Flutter Configuration

These are all the same as `flutter create` with one minor exception:

Since the @platform is currently not supported on web, that option has been disabled in `--platforms`

## Working with @platform Packages

The packages command serves as an easy way to discover @platform packages that you may want to use in your new application.

### Discovering @platform Packages

The packages have been sorted into three categories so you can filter and list based on your needs:
- Flutter packages
- Core packages
- Utility packages

In most scenarios, your project will require either the Flutter or Core packages, utility packages can be relevant to either category.

To list packages use the `list` subcommand:

```sh
at_app packages list
```

If you don't specify a category, then at_app will show you the Flutter category.

| Flag      | Shorthand | Description                |
| --------- | --------- | -------------------------- |
| --flutter | -f        | Show the Flutter category. |
| --core    | -c        | Show the core category.    |
| --util    | -u        | Show the utility category. |
| --all     | -a        | Show all categories.       |

Any combination of flags will work, however specifying `--all` or `-a` will override the other flags.

Examples:

```sh
at_app packages list     # Just Flutter
at_app packages list -f  # Just Flutter
at_app packages list -u  # Just Utility
at_app packages list -c  # Just Core
at_app packages list -fu # Flutter and Utility
at_app packages list -cu # Core and Utility
at_app packages list -fc # Flutter and Core
at_app packages list -a  # All Categories
```

### Adding packages

You can also add a package using `at_app packages add`.
You can use this, the same way as `flutter pub add`, and it can be used for any pub.dev package.

For now, we don't support the ability to specify a version, but this will be coming soon.

For example:

```sh
at_app packages add at_client_mobile
```

