<img src="https://atsign.dev/assets/img/@dev.png?sanitize=true">

### Now for a little internet optimism

# at_app_cli

A command line tool to help developers build an @ platform application.

## Who is this for?

This is for flutter developers looking to build end to end encrypted apps.

### Code user

[at_app on pub.dev](https://pub.dev/packages/at_app)

### Contributor

This is the person who we want working with us here.
[CONTRIBUTING.md](CONTRIBUTING.md) is going to have the detailed guidance on how to setup their tools,
tests and how to make a pull request.

## Why, What, How?

### Why?

An @ platform app has additional base libraries that are not included with the `flutter create` command, this tool creates a skeleton app with the prerequisites.

### What?

This is a command-line utility that can be installed and run with:

```
flutter pub global activate at_app
flutter pub global run at_app create [...options] [path-to-project]
```

### How?

This application is an extension of `flutter create`, that replaces the main.dart file with our own custom template. We also include the necessary build configuration for an @ platform android app.

## Maintainers

Created by [XavierChanth](https://github.com/xavierchanth)
