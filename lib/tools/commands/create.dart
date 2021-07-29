// @dart = 2.8
import 'package:at_app/tools/pub.dart';
import 'package:flutter_tools/src/commands/create.dart';
import 'package:flutter_tools/src/runner/flutter_command.dart';
import 'package:flutter_tools/src/cache.dart';
import 'package:flutter_tools/src/globals.dart' as globals;

const List<String> overrideArgs = [
  'template',
  'sample',
  'list-samples',
];

class AtCreateCommand extends CreateCommand {
  AtCreateCommand({
    bool verboseHelp = false,
  }) : super(verboseHelp: verboseHelp) {
    argParser.addOption(
      'namespace',
      abbr: 'n',
      help: 'The @protocol app namespace to use for the application.',
      defaultsTo: null,
      valueHelp: 'namespace',
    );
    argParser.addOption(
      'root-domain',
      abbr: 'r',
      help: 'The @protocol root domain to use for the application.',
      allowed: ['prod', 'dev', 've'],
      defaultsTo: 'prod',
      valueHelp: '[prod | dev | ve]',
    );
    argParser.addOption(
      'api-key',
      abbr: 'k',
      help: 'The api key for at_onboarding_flutter.',
      defaultsTo: '',
      valueHelp: 'api-key',
    );
    //argParser.options.removeWhere((key, value) => overrideArgs.contains(key));
    // TODO add our templates/samples
  }

  @override
  Future<FlutterCommandResult> runCommand() async {
    var flutterResult = await super.runCommand();
    if (flutterResult != FlutterCommandResult.success()) return flutterResult;

    try {
      var futureResults = [
        _updateEnvFile(),
        _addDependencies(),
        _generateMainFile(),
      ];
      await Future.wait(futureResults, eagerError: true);
    } catch (error) {
      print(error.toString());
      return FlutterCommandResult.fail();
    }

    return FlutterCommandResult.success();
  }

  Future<FlutterCommandResult> _updateEnvFile() async {
    return FlutterCommandResult.success();
  }

  Future<void> _addDependencies() async {
    globals.fs.currentDirectory = projectDir.absolute;
    await pubAdd('at_client_mobile');
    await pubAdd('at_onboarding_flutter');
    await pubAdd('at_app');
    print('done');
  }

  Future<FlutterCommandResult> _generateMainFile() async {
    return FlutterCommandResult.success();
  }
}
