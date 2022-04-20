# at_app

<img width=250px src="https://atsign.dev/assets/img/@platform_logo_grey.svg?sanitize=true">

[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](packages/at_app/LICENSE)
[![Generated App Tests](https://github.com/atsign-foundation/at_app/actions/workflows/generated_app_test.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_app/actions/workflows/generated_app_test.yaml)

at_app is a command-line tool for app developers to quickly generate a starter @platform app. at_app was designed to be the @platform's version of flutter create, and uses it behind the scenes to help you get started with your app.

## Packages

### at_app

[![pub package](https://img.shields.io/pub/v/at_app)](https://pub.dev/packages/at_app)
[![pub points](https://badges.bar/at_app/pub%20points)](https://pub.dev/packages/at_app/score)
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](packages/at_app/LICENSE)
[![Dart Analysis](https://github.com/atsign-foundation/at_app/actions/workflows/analyze_at_app.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_app/actions/workflows/analyze_at_app.yaml)

This is a command-line to make learning the @platform and building on it easier. If you are a developer working on the @platform, it is recommended that you try out this tool. [Learn More](https://pub.dev/packages/at_app).

[[View Source](/packages/at_app)]

### at_app_flutter

[![pub package](https://img.shields.io/pub/v/at_app_flutter)](https://pub.dev/packages/at_app_flutter)
[![pub points](https://badges.bar/at_app_flutter/pub%20points)](https://pub.dev/packages/at_app_flutter/score)
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](packages/at_app_flutter/LICENSE)
[![Dart Analysis](https://github.com/atsign-foundation/at_app/actions/workflows/analyze_at_app_flutter.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_app/actions/workflows/analyze_at_app_flutter.yaml)

This package is added to generated apps and provides additional functionality required by the templates. For now, all it does is read the .env file into a model called AtEnv. [Learn More](https://pub.dev/packages/at_app_flutter)

[[View Source](/packages/at_app_flutter)]

### at_app_create

[![pub package](https://img.shields.io/pub/v/at_app_create)](https://pub.dev/packages/at_app_create)
[![pub points](https://badges.bar/at_app_create/pub%20points)](https://pub.dev/packages/at_app_create/score)
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](/packages/at_app_create/LICENSE)
[![Dart Analysis](https://github.com/atsign-foundation/at_app/actions/workflows/analyze_at_app_create.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_app/actions/workflows/analyze_at_app_create.yaml)

This package provides the core code for the create command in at_app, you can depend on this package if you would like to build your own package of the tool.

[[View Source](/packages/at_app_create)]

### at_app_bundler

[![pub package](https://img.shields.io/pub/v/at_app_bundler)](https://pub.dev/packages/at_app_bundler)
[![pub points](https://badges.bar/at_app_bundler/pub%20points)](https://pub.dev/packages/at_app_bundler/score)
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](/packages/at_app_bundler/LICENSE)
[![Dart Analysis](https://github.com/atsign-foundation/at_app/actions/workflows/analyze_at_app_bundler.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_app/actions/workflows/analyze_at_app_bundler.yaml)

This is a command-line bundler tool for at_app_create, it allows you to easily bundle a mason brick (with an additional template.yaml file) into the necessary at_app_create models to generate an entire Flutter application from.

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
