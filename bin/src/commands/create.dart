// @dart = 2.8
import 'dart:io';

import '../file/android/app_build_gradle_manager.dart';
import '../file/android/gradle_properties_manager.dart';
import '../pub.dart' as pub;
import 'package:flutter_tools/src/commands/create.dart';
import 'package:flutter_tools/src/runner/flutter_command.dart';
import 'package:path/path.dart' as path;
import '../file/env_manager.dart';
import '../file/template_manager.dart';

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

List<String> packages = [
  'at_client_mobile',
  'at_onboarding_flutter',
  'at_app',
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
    var mainFileManager = TemplateManager(
      projectDir,
      'lib/main.dart',
      '${Platform.script.toFilePath()}/../../lib/templates/main.dart',
    );
    var mainExists = mainFileManager.existsSync;
    var flutterResult = await super.runCommand();
    if (flutterResult != FlutterCommandResult.success()) return flutterResult;

    var results;

    try {
      var futureResults = [
        _updateEnvFile(),
        _addDependencies(),
        _generateMainFile(mainFileManager, mainExists),
        _androidConfig()
      ];

      results = await Future.wait(futureResults, eagerError: true);
    } catch (error) {
      print(error.toString());
      return FlutterCommandResult.fail();
    }

    if (results.any((res) => !res)) {
      print('There was an issue creating your project.');
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

  Future<bool> _updateEnvFile() async {
    var values = _parseEnvArgs();
    return await EnvManager(projectDir, '.env').update(values);
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

  Future<bool> _addDependencies() async {
    for (var package in packages) {
      var success = await pub.add(
        package,
        isDev: true, // TODO set to false for production
        directory: projectDir,
      );
      if (!success) return false;
    }
    return true;
  }

  // * copy the main.dart for skeleton_app

  Future<bool> _generateMainFile(
      TemplateManager mainFileManager, bool mainExists) async {
    if (!mainExists) return await mainFileManager.copyTemplate();
    return true;
  }

  // * update the flutter android config

  Future<bool> _androidConfig() async {
    List<Future> futures = [
      GradlePropertiesManager(projectDir).update(),
      AppBuildGradleManager(projectDir).update()
    ];
    return (await Future.wait(futures)).every((res) => res);
  }
}
