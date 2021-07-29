// @dart = 2.8

import 'dart:io';

import 'package:flutter_tools/src/runner/flutter_command.dart';
import 'package:at_app/tools/custom_executable.dart';
import 'package:flutter_tools/src/commands/packages.dart';
import 'package:flutter_tools/src/dart/pub.dart';
import 'package:flutter_tools/src/globals.dart' as globals;

final stdio = globals.stdio;

Future<void> pubAdd(String package,
    {bool isLocal = false, String directory}) async {
  var args = (isLocal)
      ? ['add', '--path', Directory.current.absolute.path, package] // TODO needs to be relative path
      : ['add', package];
  print(args);
  print(directory);
  await pub.interactively(
    args,
    directory: directory,
    stdio: stdio,
  );
}

Future<void> pubGet(String package, {String directory}) async {
  await pub.interactively(
    ['pub', 'get'],
    directory: directory,
    stdio: stdio,
  );
}

List<FlutterCommand> generateCommands({bool verboseHelp}) {
  return <FlutterCommand>[
    PackagesCommand(),
  ];
}
