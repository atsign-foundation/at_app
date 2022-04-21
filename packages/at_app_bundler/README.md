


# at_app_bundler

<img width=250px src="https://atsign.dev/assets/img/@platform_logo_grey.svg?sanitize=true">

[![pub package](https://img.shields.io/pub/v/at_app_bundler)](https://pub.dev/packages/at_app_bundler)
[![pub points](https://badges.bar/at_app_bundler/pub%20points)](https://pub.dev/packages/at_app_bundler/score)
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](./LICENSE)
[![Generated App Tests](https://github.com/atsign-foundation/at_app/actions/workflows/generated_app_test.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_app/actions/workflows/generated_app_test.yaml)
[![Dart Analysis](https://github.com/atsign-foundation/at_app/actions/workflows/analyze_at_app_flutter.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_app/actions/workflows/analyze_at_app_flutter.yaml)

## Overview

at_app_bundler is a bundler that generates dart models for [at_app_create](https://pub.dev/packages/at_app_create).

## Get started

To get started, install the tool using pub:

```sh
dart pub global activate at_app_bundler
```

*Additionally, pub may prompt you to add the global bin to your PATH variable, please do so before proceeding.

## How it works

at_app_bundler bundles a modified version of a [mason brick](https://pub.dev/packages/mason_cli#creating-new-bricks) into the necessary dart models for at_app_create. You can build this custom brick by including an additional `template.yaml` file in your brick.

### Usage

See the [Example tab](https://pub.dev/packages/at_app_bundler/example) on pub.dev.

## Open source usage and contributions

This is open source code, so feel free to use it as is, suggest changes or
enhancements or create your own version. See [CONTRIBUTING.md](../../CONTRIBUTING.md)
for detailed guidance on how to setup tools, tests and make a pull request.

## Acknowledgement/attribution

This package was originally created by [Xavier Chanthavong](https://github.com/xavierchanth).

## Maintainers

This package is currently maintained by [Xavier Chanthavong](https://github.com/xavierchanth).
