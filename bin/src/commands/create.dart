// @dart = 2.8
import '../pub.dart';
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
    // TODO add our templates/samples
  }

  @override
  Future<FlutterCommandResult> runCommand() async {
    bool shouldGenerateMain = false; //Check if main already exists here
    var flutterResult = await super.runCommand();
    if (flutterResult != FlutterCommandResult.success()) return flutterResult;

    try {
      var futureResults = [
        _updateEnvFile(),
        _addDependencies(),
        _generateMainFile(shouldGenerateMain),
      ];

      await Future.wait(futureResults, eagerError: true);
    } catch (error) {
      print(error.toString());
      return FlutterCommandResult.fail();
    }

    print(
      '\n'
      'Your @app template has been successfully created!\n'
      '\n'
      'Verify the project with:\n'
      '  > cd ${projectDir.path}\n'
      '  > flutter pub get\n',
    );

    return FlutterCommandResult.success();
  }

  Future<FlutterCommandResult> _updateEnvFile() async {
    // Check if .env exists
    // Regex to check for each line
    // Update with new parameters
    return null;
  }

  Future<FlutterCommandResult> _addDependencies() async {
    var directory = projectDir.absolute.path;

    await pubAdd('at_client_mobile', directory: directory);
    await pubAdd('at_onboarding_flutter', directory: directory);
    await pubAdd('at_app',
        isLocal: true, // TODO isLocal = false before publishing
        directory: directory);
    return null;
  }

  Future<FlutterCommandResult> _generateMainFile(bool shouldGenerate) async {
    if (shouldGenerate) {
      // Replace the existing main file
    }
    return null;
  }
}
