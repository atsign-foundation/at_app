import 'dart:io' show Directory;

import 'package:args/command_runner.dart' show Command, UsageException;
import 'package:path/path.dart' show basename, normalize;

import '../constants/platforms.dart';
import '../constants/dart_keywords.dart';

abstract class AtCreateCommand<T> extends Command<T> {
  @override
  final String name = 'create';

  final T successValue;

  AtCreateCommand({
    required this.successValue,
    List<String>? availablePlatforms,
    List<String>? allCreatePlatforms,
    String? platformHelp,
  }) {
    // flutter create Arguments
    // Copyright 2014 The Flutter Authors. All rights reserved.
    argParser.addFlag(
      'pub',
      defaultsTo: true,
      help: 'Whether to run "flutter pub get" after the project has been created.',
    );
    argParser.addFlag(
      'overwrite',
      defaultsTo: false,
      help: 'When performing operations, overwrite existing files.',
    );
    argParser.addOption(
      'description',
      defaultsTo: 'A new Flutter project.',
      help: 'The description to use for your new Flutter project. This string ends up in the pubspec.yaml file.',
    );
    argParser.addOption(
      'org',
      defaultsTo: 'com.example',
      help: 'The organization responsible for your new Flutter project, in reverse domain name notation. '
          'This string is used in Java package names and as prefix in the iOS bundle identifier.',
    );
    argParser.addOption(
      'project-name',
      defaultsTo: null,
      help: 'The project name for this new Flutter project. This must be a valid dart package name.',
    );
    argParser.addMultiOption(
      'platforms',
      defaultsTo: availablePlatforms ?? defaultAvailablePlatforms,
      allowed: allCreatePlatforms ?? defaultAllCreatePlatforms,
      help: platformHelp ?? defaultPlatformHelp,
    );
  }

  bool? boolArg(String name) => argResults?[name] as bool?;
  String? stringArg(String name) => argResults?[name] as String?;
  List<String>? lStringArg(String name) => argResults?[name] as List<String>?;

  @override
  Future<T> run() async {
    validateOutputDirectoryArg();

    if (!validatePackageName(packageName)) {
      throw FormatException('"$packageName" is not a valid Dart package name.\n\n'
          'See https://dart.dev/tools/pub/pubspec#name for more information.');
    }

    if (!validateOrg()) {
      throw FormatException('"${stringArg('org')}" is not a valid org name\n\n',
          'See https://en.wikipedia.org/wiki/Uniform_Type_Identifier for more information');
    }

    return successValue;
  }

  void validateOutputDirectoryArg() {
    if (argResults?.rest.isEmpty ?? false) {
      throw UsageException('No option specified for the output directory.', usage);
    }

    if (argResults!.rest.length > 1) {
      String message = 'Multiple output directories specified.';
      for (final String arg in argResults!.rest) {
        if (arg.startsWith('-')) {
          message += '\nTry moving $arg to be immediately following $name';
          break;
        }
      }
      throw FormatException(message);
    }
  }

  bool validateOrg() {
    String validator = '^[A-Za-z]{2,6}((?!-).[A-Za-z0-9-]{1,63})+\$';
    if (argResults!.wasParsed('org')) {
      String org = stringArg('org')!;
      Match? match = RegExp(validator).matchAsPrefix(org);
      return match != null && match.end == org.length;
    }
    return true;
  }

  String get packageName {
    String? projectName = stringArg('project-name');
    return projectName ?? basename(normalize(projectDir.absolute.path));
  }

  // Copyright 2014 The Flutter Authors. All rights reserved.
  bool validatePackageName(String name) {
    final Match? match = RegExp('[a-z_][a-z0-9_]*').matchAsPrefix(name);
    return match != null && match.end == name.length && !dartKeywords.contains(name);
  }

  Directory get projectDir {
    return Directory(argResults!.rest.first);
  }
}
