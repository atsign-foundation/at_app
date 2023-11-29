# at_app_bundler

<a href="https://atsign.com#gh-light-mode-only"><img width=250px src="https://atsign.com/wp-content/uploads/2022/05/atsign-logo-horizontal-color2022.svg#gh-light-mode-only" alt="The Atsign Foundation"></a><a href="https://atsign.com#gh-dark-mode-only"><img width=250px src="https://atsign.com/wp-content/uploads/2023/08/atsign-logo-horizontal-reverse2022-Color.svg#gh-dark-mode-only" alt="The Atsign Foundation"></a>

[![pub package](https://img.shields.io/pub/v/at_app_bundler)](https://pub.dev/packages/at_app_bundler)
[![pub points](https://img.shields.io/pub/points/at_app_bundler?logo=dart))](https://pub.dev/packages/at_app_bundler/score)
[![gitHub license](https://img.shields.io/badge/license-BSD3-blue.svg)](./LICENSE)
[![CI](https://github.com/atsign-foundation/at_app/actions/workflows/CI.yaml/badge.svg?branch=trunk)](https://github.com/atsign-foundation/at_app/actions/workflows/CI.yaml)

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
