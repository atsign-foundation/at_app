# at_app

<a href="https://atsign.com#gh-light-mode-only"><img width=250px src="https://atsign.com/wp-content/uploads/2022/05/atsign-logo-horizontal-color2022.svg#gh-light-mode-only" alt="The Atsign Foundation"></a><a href="https://atsign.com#gh-dark-mode-only"><img width=250px src="https://atsign.com/wp-content/uploads/2023/08/atsign-logo-horizontal-reverse2022-Color.svg#gh-dark-mode-only" alt="The Atsign Foundation"></a>

[![pub package](https://img.shields.io/pub/v/at_app)](https://pub.dev/packages/at_app)
[![pub points](https://img.shields.io/badge/dynamic/json?url=https://pub.dev/api/packages/at_app/score&label=pub%20score&query=grantedPoints)]([https://pub.dev/packages/at_app](https://pub.dev/packages/at_app/score))
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](./LICENSE)
[![CI](https://github.com/atsign-foundation/at_app/actions/workflows/CI.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_app/actions/workflows/CI.yaml)

## Overview

at_app is the one-stop shop for Flutter developers developing with, or trying out the atPlatform.

This open source application is written in Dart, and is designed to help you run apps on the
atPlatform's decentralized, edge computing model. at_app can help you to:
- Get started on the atPlatform
- Build an app using our starter templates
- Discover and learn about atPlatform packages that may be useful to your project

Features of the atPlatform include:
- Cryptographic control of data access through personal data stores
- No application backend needed
- End to end encryption where only the data owner has the keys
- Private and surveillance free connectivity
- Integrate packages quickly and easily

We call giving people control of access to their data “flipping the internet”
and you can learn more about how it works by reading this
[overview](https://docs.atsign.com/atplatform/atplatformoverview/).

## Get started

To get started, install the tool using pub:

```sh
dart pub global activate at_app
```

*Additionally, pub may prompt you to add the global bin to your PATH variable, please do so before proceeding.

## How it works

at_app contains an internal templating engine which is an extension of the [mason package](https://pub.dev/packages/mason).
The templating engine is contained within it's own package called [at_app_create](https://pub.dev/packages/at_app_create),
which you can depend on if you would like to create your own version of this application.

### Usage

See the [Example tab](https://pub.dev/packages/at_app/example) on pub.dev.
Alternatively, follow our [tutorial](https://docs.atsign.com/tutorials/at-dude/1-introduction/) which uses this application to help you get started on the atPlatform.

## Open source usage and contributions

This is open source code, so feel free to use it as is, suggest changes or
enhancements or create your own version. See [CONTRIBUTING.md](../../CONTRIBUTING.md)
for detailed guidance on how to setup tools, tests and make a pull request.

## Acknowledgement/attribution

This package was originally created by [Xavier Chanthavong](https://github.com/xavierchanth).

### Copyright notice

Copyright 2014 The Flutter Authors. All rights reserved.

This project reuses parts of the Flutter SDK in order to achieve a similar experience to the `flutter create` command.
Please see the original license [here](https://github.com/flutter/flutter/blob/master/LICENSE).

## Maintainers

This package is currently maintained by [Xavier Chanthavong](https://github.com/xavierchanth).
