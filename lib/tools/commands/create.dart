// @dart = 2.8
import 'package:at_app/tools/pub.dart';
import 'package:flutter_tools/src/commands/create.dart';
import 'package:flutter_tools/src/runner/flutter_command.dart';

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
    var packages = ['at_client_mobile', 'at_onboarding_flutter', 'at_app'];
    var futures = packages.map((package) => pubAdd(package)).toList();
    await Future.wait(futures);
  }

  Future<FlutterCommandResult> _generateMainFile() async {
    return FlutterCommandResult.success();
  }
}