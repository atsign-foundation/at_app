// @dart = 2.8
import 'package:flutter_tools/src/runner/flutter_command.dart';
import 'package:at_app/tools/custom_executable.dart';
import 'package:flutter_tools/src/commands/packages.dart';

Future<void> pubAdd(String package) async {
  await run(['pub', 'add', package], generateCommands);
}

Future<void> pubGet(String package) async {
  await run(['pub', 'get'], generateCommands);
}

List<FlutterCommand> generateCommands({bool verboseHelp}) {
  return <FlutterCommand>[
    PackagesCommand(),
  ];
}
