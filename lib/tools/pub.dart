// @dart = 2.8

import 'dart:io';

import 'package:flutter_tools/src/runner/flutter_command.dart';
import 'package:at_app/tools/custom_executable.dart';
import 'package:flutter_tools/src/commands/packages.dart';
import 'package:flutter_tools/src/dart/pub.dart';
import 'package:flutter_tools/src/globals.dart' as globals;

Future<void> pubAdd(String package) async {
  await pub.interactively(['add', package], stdio: globals.stdio);
}

Future<void> pubGet(String package) async {
  await pub.interactively(['pub', 'get'], stdio: globals.stdio);
}

List<FlutterCommand> generateCommands({bool verboseHelp}) {
  return <FlutterCommand>[
    PackagesCommand(),
  ];
}
