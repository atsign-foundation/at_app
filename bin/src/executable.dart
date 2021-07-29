// Copyright 2014 The Flutter Authors. All rights reserved.

// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:

//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.


// * This file is from the flutter sdk package: flutter_tools/executable.dart
// * modification: generateCommands function is now an argument passed to run


// @dart = 2.8

import 'package:flutter_tools/src/runner/flutter_command.dart';
import 'package:flutter_tools/runner.dart' as runner;
import 'package:flutter_tools/executable.dart' show LoggerFactory;
import 'package:flutter_tools/src/globals.dart' as globals;
import 'package:flutter_tools/src/cache.dart';
import 'package:flutter_tools/src/base/platform.dart';
import 'package:flutter_tools/src/base/user_messages.dart';
import 'package:flutter_tools/src/base/context.dart';
import 'package:flutter_tools/src/base/template.dart';
import 'package:flutter_tools/src/isolated/resident_web_runner.dart';
import 'package:flutter_tools/src/isolated/mustache_template.dart';
import 'package:flutter_tools/src/web/web_runner.dart';
import 'package:flutter_tools/src/resident_runner.dart';
import 'package:flutter_tools/src/devtools_launcher.dart';
import 'package:flutter_tools/src/artifacts.dart';
import 'package:flutter_tools/src/base/logger.dart';

Future<void> run(
  List<String> args,
  List<FlutterCommand> Function({bool verboseHelp}) generateCommands,
) async {
  final veryVerbose = args.contains('-vv');
  final verbose =
      args.contains('-v') || args.contains('--verbose') || veryVerbose;
  final prefixedErrors = args.contains('--prefixed-errors');
  // Support the -? Powershell help idiom.
  final powershellHelpIndex = args.indexOf('-?');
  if (powershellHelpIndex != -1) {
    args[powershellHelpIndex] = '-h';
  }

  final doctor = (args.isNotEmpty && args.first == 'doctor') ||
      (args.length == 2 && verbose && args.last == 'doctor');
  final help = args.contains('-h') ||
      args.contains('--help') ||
      (args.isNotEmpty && args.first == 'help') ||
      (args.length == 1 && verbose);
  final muteCommandLogging = (help || doctor) && !veryVerbose;
  final verboseHelp = help && verbose;
  final daemon = args.contains('daemon');
  final runMachine = (args.contains('--machine') && args.contains('run')) ||
      (args.contains('--machine') && args.contains('attach'));

  // Cache.flutterRoot must be set early because other features use it (e.g.
  // enginePath's initializer uses it). This can only work with the real
  // instances of the platform or filesystem, so just use those.
  Cache.flutterRoot = Cache.defaultFlutterRoot(
    platform: const LocalPlatform(),
    fileSystem: globals.localFileSystem,
    userMessages: UserMessages(),
  );

  await runner.run(
    args,
    () => generateCommands(
      verboseHelp: verboseHelp,
    ),
    verbose: verbose,
    muteCommandLogging: muteCommandLogging,
    verboseHelp: verboseHelp,
    overrides: <Type, Generator>{
      // The web runner is not supported in google3 because it depends
      // on dwds.
      WebRunnerFactory: () => DwdsWebRunnerFactory(),
      // The mustache dependency is different in google3
      TemplateRenderer: () => const MustacheTemplateRenderer(),
      // The devtools launcher is not supported in google3 because it depends on
      // devtools source code.
      DevtoolsLauncher: () => DevtoolsServerLauncher(
            processManager: globals.processManager,
            pubExecutable:
                globals.artifacts.getArtifactPath(Artifact.pubExecutable),
            logger: globals.logger,
            platform: globals.platform,
            persistentToolState: globals.persistentToolState,
          ),
      Logger: () {
        final loggerFactory = LoggerFactory(
          outputPreferences: globals.outputPreferences,
          terminal: globals.terminal,
          stdio: globals.stdio,
        );
        return loggerFactory.createLogger(
          daemon: daemon,
          machine: runMachine,
          verbose: verbose && !muteCommandLogging,
          prefixedErrors: prefixedErrors,
          windows: globals.platform.isWindows,
        );
      },
    },
  );
}
