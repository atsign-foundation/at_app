# at_app

<img width=250px src="https://atsign.dev/assets/img/@platform_logo_grey.svg?sanitize=true">

[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](packages/at_app/LICENSE)
[![CI](https://github.com/atsign-foundation/at_app/actions/workflows/CI.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_app/actions/workflows/CI.yaml)

at_app is a command-line tool for app developers to quickly generate a starter atPlatform app. at_app was designed to be the atPlatform's version of flutter create, and uses it behind the scenes to help you get started with your app.

## Packages

### at_app

[![pub package](https://img.shields.io/pub/v/at_app)](https://pub.dev/packages/at_app)
[![pub points](https://badges.bar/at_app/pub%20points)](https://pub.dev/packages/at_app/score)
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](packages/at_app/LICENSE)

This is a command-line to make learning the atPlatform and building on it easier. If you are a developer working on the atPlatform, it is recommended that you try out this tool.

[[View on pub.dev](https://pub.dev/packages/at_app)]

[[View Source](/packages/at_app)]

### at_app_flutter

[![pub package](https://img.shields.io/pub/v/at_app_flutter)](https://pub.dev/packages/at_app_flutter)
[![pub points](https://badges.bar/at_app_flutter/pub%20points)](https://pub.dev/packages/at_app_flutter/score)
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](packages/at_app_flutter/LICENSE)

This package is added to generated apps and provides additional functionality required by the templates. For now, all it does is read the .env file into a model called AtEnv.

[[View on pub.dev](https://pub.dev/packages/at_app_flutter)]

[[View Source](/packages/at_app_flutter)]

### at_app_create

[![pub package](https://img.shields.io/pub/v/at_app_create)](https://pub.dev/packages/at_app_create)
[![pub points](https://badges.bar/at_app_create/pub%20points)](https://pub.dev/packages/at_app_create/score)
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](/packages/at_app_create/LICENSE)

This package provides the core code for the create command in at_app, you can depend on this package if you would like to build your own package of the tool.

[[View on pub.dev](https://pub.dev/packages/at_app_create)]

[[View Source](/packages/at_app_create)]

### at_app_bundler

[![pub package](https://img.shields.io/pub/v/at_app_bundler)](https://pub.dev/packages/at_app_bundler)
[![pub points](https://badges.bar/at_app_bundler/pub%20points)](https://pub.dev/packages/at_app_bundler/score)
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](/packages/at_app_bundler/LICENSE)


This is a command-line bundler tool for at_app_create, it allows you to easily bundle a mason brick (with an additional template.yaml file) into the necessary at_app_create models to generate an entire Flutter application from.

[[View on pub.dev](https://pub.dev/packages/at_app_bundler)]

[[View Source](/packages/at_app_bundler)]


## Open source usage and contributions

This is open source code, so feel free to use it as is, suggest changes or
enhancements or create your own version. See [CONTRIBUTING.md](./CONTRIBUTING.md)
for detailed guidance on how to setup tools, tests and make a pull request.

## Acknowledgement/attribution

This project was originally created by [Xavier Chanthavong](https://github.com/xavierchanth).

### Copyright notice

Copyright 2014 The Flutter Authors. All rights reserved.

This project has copied some variables from the `flutter create` tool in order to give developers a familiar experience.
Variables have been annotated with the copyright.

Please see the original license [here](https://github.com/flutter/flutter/blob/master/LICENSE).

## Maintainers

This project is currently maintained by [Xavier Chanthavong](https://github.com/xavierchanth)
