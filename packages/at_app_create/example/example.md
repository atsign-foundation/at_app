# Usage

The following provides a full guide on how to use at_app_create.

- [Usage](#usage)
  - [Overview](#overview)
  - [Template Models](#template-models)
    - [Custom Variables](#custom-variables)
  - [Command Models](#command-models)

## Overview

There are two portions of this library that you can depend on.

1. The template models  
  This contains the dart model capable of generating Flutter app templates.
2. The args package command models
  Contains an abstract model from which you can build your create command using the [args package](https://pub.dev/packages/args).

## Template Models

The template models as a whole are an abstraction that generates an entire Flutter app from several mason bundles.

Each platform configuration directory is its own template (for now just `android` & `ios`, the rest of the platforms coming soon), and there is also a root project template that generates the `pubspec.yaml`, `.gitignore`, and `README.md`.

If you don't require any variables to be passed into your code template, it is recommended that you see [https://pub.dev/packages/at_app_bundler] to bundle your templates from minimal code. Some practical examples of bundled templates are available in the [at_app package](../../at_app/lib/src/bundles/).

### Custom Variables

If you would like to use custom variables in your code templates, then you will have to extend the models to add your additional variables. See the example [here](custom_variables/example.dart).

## Command Models

As of now there is only one command model, an abstraction of the create command. This model defines the basis for building your own create command. See the [at_app package](../../at_app/lib/src/command/../commands/create.dart) create command implementation for reference.


