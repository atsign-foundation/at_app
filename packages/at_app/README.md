# at_app

<img width=250px src="https://atsign.dev/assets/img/@platform_logo_grey.svg?sanitize=true">

[![pub package](https://img.shields.io/pub/v/at_app)](https://pub.dev/packages/at_app)
[![pub points](https://badges.bar/at_app/pub%20points)](https://pub.dev/packages/at_app/score)
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](./LICENSE)
[![CI](https://github.com/atsign-foundation/at_app/actions/workflows/CI.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_app/actions/workflows/CI.yaml)

## Overview

at_app is the one-stop shop for Flutter developers developing with, or trying out the @platform.

This open source application is written in Dart, and is designed to help you run apps on the
@platform's decentralized, edge computing model. at_app can help you to:
- Get started on the @platform
- Build an app using our starter templates
- Discover and learn about @platform packages that may be useful to your project

Features of the @platform include:
- Cryptographic control of data access through personal data stores
- No application backend needed
- End to end encryption where only the data owner has the keys
- Private and surveillance free connectivity
- Integrate packages quickly and easily

We call giving people control of access to their data “flipping the internet”
and you can learn more about how it works by reading this
[overview](https://atsign.dev/docs/overview/).

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
Alternatively, follow our [5 step introductory tutorial](https://atsign.dev/docs/get-started/tryatplatform/) which uses this application to help you get started on the @platform.

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
