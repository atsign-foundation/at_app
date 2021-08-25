import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;

import '../util/command_status.dart';
import '../util/exceptions.dart';
import '../util/file/index.dart';
import '../util/cli/flutter.dart';
import '../util/printer.dart';
import 'create_base.dart';

class CreateCommand extends CreateBase {
  final String description = 'Create a new @platform Flutter project.';
  final Logger _logger;
  CreateCommand({Logger? logger})
      : _logger =
            logger ?? Logger(filter: ProductionFilter(), printer: Printer()),
        super(logger: logger) {
    argParser.addOption(
      'namespace',
      abbr: 'n',
      help: 'The @protocol app namespace to use for the application.',
      defaultsTo: '',
      valueHelp: 'namespace',
    );
    argParser.addOption(
      'root-domain',
      abbr: 'r',
      help: 'The @protocol root domain to use for the application.',
      allowed: ['prod', 've'],
      defaultsTo: 'prod',
      valueHelp: 'prod | ve',
    );
    argParser.addOption(
      'api-key',
      abbr: 'k',
      help: 'The api key for at_onboarding_flutter.',
      defaultsTo: '',
      valueHelp: 'api-key',
    );
  }

  @override
  Future<CommandStatus> run() async {
    validateOutputDirectoryArg();

    final bool creatingNewProject =
        !outputDirectory.existsSync() || outputDirectory.listSync().isEmpty;

    final TemplateManager mainFileManager =
        TemplateManager(outputDirectory, 'main.dart');

    final bool shouldWriteMainFile =
        !mainFileManager.existsSync || (boolArg('overwrite') ?? false);

    final String relativeOutputPath =
        path.relative(outputDirectory.absolute.path);

    final String relativeAppMain =
        path.join(relativeOutputPath, 'lib', 'main.dart');

    if (creatingNewProject) {
      _logger.i('Creating project in $relativeOutputPath...');
    } else {
      _logger.i('Recreating project in $relativeOutputPath...');
    }

    CommandStatus flutterCreateResult = await super.run();
    if (flutterCreateResult != CommandStatus.success) {
      return flutterCreateResult;
    }

    _logger.i('');
    _logger.i('Project created, now adding a little @ magic...');

    List<Future> futures = [];

    for (Function f in [updateEnvFile, addDependencies, androidConfig]) {
      try {
        futures.add(f());
      } catch (e) {
        _logger.w(e.toString());
      }
    }

    await Future.wait(futures);

    // Should be completed after addDependencies
    // so that we can expect at_app to be in the pub cache
    try {
      if (shouldWriteMainFile) await mainFileManager.copyTemplate();
    } catch (e) {
      throw TemplateFileException();
    }

    _logger.i('');
    _logger.i('All done!');

    _logger.i('''

In order to run your @platform application, type:

\$ cd $relativeOutputPath
\$ flutter run

Your application code is in $relativeAppMain.

Happy coding!
''');

    return CommandStatus.success;
  }

  /// Updates the environment variables from the command arguments
  Future<void> updateEnvFile() async {
    try {
      var values = parseEnvArgs();
      // generatedFileCount++;
      await EnvManager(outputDirectory).update(values);
    } catch (e) {
      throw EnvException();
    }
  }

  /// Parses the environment variables from the command arguments
  Map<String, String> parseEnvArgs() {
    assert(argResults != null);
    Map<String, String> result = {};
    if (argResults!.wasParsed('namespace')) {
      result['NAMESPACE'] = stringArg('namespace')!;
    }
    if (argResults!.wasParsed('root-domain')) {
      result['ROOT_DOMAIN'] = getRootDomain(stringArg('root-domain')!);
    }
    if (argResults!.wasParsed('api-key')) {
      result['API_KEY'] = stringArg('api-key')!;
    }
    return result;
  }

  /// Get the full rootDomain for the specified [flag]
  String getRootDomain(String flag) {
    switch (flag) {
      case 've':
        return 'vip.ve.atsign.zone';
      case 'prod':
      default:
        return 'root.atsign.org';
    }
  }

  /// Dependencies for the @platform app
  Future<void> addDependencies() async {
    assert(argResults != null);
    final List<String> packages = [
      'at_client_mobile',
      'at_onboarding_flutter',
      'at_app_flutter'
    ];
    // TODO check if flutter is available first
    List<Future> futures = packages.map((package) async {
      try {
        return await Flutter.pubAdd(package, directory: outputDirectory);
      } catch (e) {
        _logger.w(
            'Package $package was not added, please manually add if necessary.');
      }
    }).toList();
    await Future.wait(futures);
    if (boolArg('pub')!) {
      try {
        await Flutter.pubGet(directory: outputDirectory);
      } catch (e) {
        _logger.w('Unable to pub get in ${outputDirectory.path}');
      }
    }
  }

  /// Required Android build configuration
  Future<void> androidConfig() async {
    try {
      await Future.wait([
        GradlePropertiesManager(outputDirectory).update(),
        AppBuildGradleManager(outputDirectory).update()
      ]);
    } catch (e) {
      throw AndroidBuildException();
    }
  }
}
