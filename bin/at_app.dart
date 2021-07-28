// @dart = 2.8
import 'package:at_app/commands/create.dart';
import 'package:flutter_tools/runner.dart' as runner;
import 'package:flutter_tools/src/runner/flutter_command.dart';
import 'package:flutter_tools/src/globals.dart' as globals;
import 'package:flutter_tools/src/cache.dart';
import 'package:flutter_tools/src/base/platform.dart';
import 'package:flutter_tools/src/base/user_messages.dart';

Future<void> main(List<String> args) async {
  final veryVerbose = args.contains('-vv');
  final verbose =
      args.contains('-v') || args.contains('--verbose') || veryVerbose;
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
  );
}

List<FlutterCommand> generateCommands({bool verboseHelp}) {
  return <FlutterCommand>[
    AtCreateCommand(verboseHelp: verboseHelp),
  ];
}
