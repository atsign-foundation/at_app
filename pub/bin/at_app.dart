// @dart = 2.8
import 'package:flutter_tools/src/runner/flutter_command.dart';
import 'src/executable.dart';
import 'src/commands/create.dart';

Future<void> main(List<String> args) async {
  await run(args, generateCommands);
}

List<FlutterCommand> generateCommands({bool verboseHelp}) {
  return <FlutterCommand>[
    AtCreateCommand(verboseHelp: verboseHelp),
  ];
}
