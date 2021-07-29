// @dart = 2.8
import '../env.dart';
import '../pub.dart' as pub;
import 'package:flutter_tools/src/commands/create.dart';
import 'package:flutter_tools/src/runner/flutter_command.dart';

const List<String> overrideArgs = [
  'template',
  'sample',
  'list-samples',
];

const Map<String, String> envArgs = {
  'namespace': 'NAMESPACE',
  'root-domain': 'ROOT_DOMAIN',
  'api-key': 'API_KEY',
};

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
      valueHelp: 'prod | dev | ve',
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

  // * .env file

  Future<FlutterCommandResult> _updateEnvFile() async {
    var values = _parseEnvArgs();
    EnvManager(projectDir).update(values);
    return null;
  }

  Map<String, String> _parseEnvArgs() {
    Map<String, String> result = {};
    envArgs.keys.forEach((element) {
      if (argResults[element] != null) {
        if (element == 'root-domain') {
          result[envArgs[element]] = _getRootDomain(argResults[element]);
        } else {
          result[envArgs[element]] = argResults[element];
        }
      }
    });
    return result;
  }

  String _getRootDomain(String flag) {
    switch (flag) {
      case 'prod':
        return 'root.atsign.org';
      case 'dev':
        return 'root.atsign.wtf';
      case 've':
        return 'vip.ve.atsign.zone';
      default:
        return '';
    }
  }

  // * dependencies for skeleton_app

  Future<FlutterCommandResult> _addDependencies() async {
    await pub.add('at_client_mobile', directory: projectDir);
    await pub.add('at_onboarding_flutter', directory: projectDir);
    await pub.add(
      'at_app',
      isLocal: true, // TODO isLocal = false before publishing
      directory: projectDir,
    );
    return null;
  }

  // * copy the main.dart for skeleton_app

  Future<FlutterCommandResult> _generateMainFile(bool shouldGenerate) async {
    if (shouldGenerate) {
      // Replace the existing main file
    }
    return null;
  }
}
