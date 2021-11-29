import 'package:at_app/src/services/logger.dart';

import '../util/namespace.dart';
import 'package:logger/logger.dart' show Logger;
import 'package:path/path.dart' show join, relative;

import '../util/cache_package.dart';
import '../cli/flutter_cli.dart';
import '../models/exceptions/android_build_exception.dart';
import '../models/exceptions/env_exception.dart';
import '../models/exceptions/package_exception.dart';
import '../models/exceptions/template_exception.dart';
import '../util/template_manager.dart';
import '../../version.dart';
import '../models/command_status.dart';
import 'create_base.dart';

/// This class extends the flutter create abstraction,
/// It will pull templates from at_app_flutter
/// and uses the respective template generator to generate the full template.
class CreateCommand extends CreateBase {
  @override
  final String description = 'Create a new @platform Flutter project.';
  final Logger _logger = LoggerService().logger;
  CreateCommand({Logger? logger}) : super(logger: logger) {
    argParser.addOption(
      'namespace',
      abbr: 'n',
      help:
          'The @protocol app namespace to use for the application. (Use an @sign you own)',
      defaultsTo: '',
      valueHelp: '@youratsign',
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
    argParser.addOption('template',
        abbr: 't',
        help: 'The template to generate.',
        allowed: ['app'],
        defaultsTo: 'app',
        valueHelp: 'template-name',
        hide: true);
    //TODO samples
  }

  @override
  Future<CommandStatus> run() async {
    validateOutputDirectoryArg();

    validateEnvironment();

    /// These variables are for print formatting
    final bool creatingNewProject =
        !projectDir.existsSync() || projectDir.listSync().isEmpty;

    final String relativeOutputPath = relative(projectDir.absolute.path);

    final String relativeAppMain = join(relativeOutputPath, 'lib', 'main.dart');

    // Copyright 2014 The Flutter Authors. All rights reserved.
    if (creatingNewProject) {
      _logger.i('Creating project in $relativeOutputPath');
    } else {
      _logger.i('Recreating project in $relativeOutputPath');
    }

    /// Run create_base before running the rest of create
    CommandStatus flutterCreateResult = await super.run();
    if (flutterCreateResult != CommandStatus.success) {
      return flutterCreateResult;
    }

    _logger.i('');
    if (creatingNewProject) {
      _logger.i('Project created, now adding a little @ magic...');
    } else {
      _logger.i('Project recreated, now adding a little @ magic...');
    }

    try {
      /// pub add at_app_flutter before generating the template
      /// this ensures that we can pull the template from the pub cache
      await addDependency();

      /// Generate the template
      await TemplateManager(
              stringArg('template') ?? 'app', projectDir, argResults!)
          .generateTemplate();
    } on AndroidBuildException {
      _logger.e('Failed to setup the android build configuration.');
      return CommandStatus.fail;
    } on EnvException {
      _logger.e('Failed to setup the @platform environment.');
      return CommandStatus.fail;
    } on TemplateException {
      _logger.e('Failed to transfer a template file.');
      return CommandStatus.fail;
    } on PackageException {
      _logger.e('Failed to get a package from the pub cache.');
      return CommandStatus.fail;
    } catch (e) {
      _logger.e(e.toString(), e);
      return CommandStatus.fail;
    }

    _logger.i('');
    _logger.i('All done!');

    // Copyright 2014 The Flutter Authors. All rights reserved.
    _logger.i('''

In order to run your @platform application, type:

\$ cd $relativeOutputPath
\$ flutter run

Your application code is in $relativeAppMain.

Happy coding!
''');

    return CommandStatus.success;
  }

  void validateEnvironment() {
    if (argResults!.wasParsed('namespace')) {
      normalizeNamespace(argResults!['namespace'] as String);
    }
  }

  /// Install at_app_flutter to pub cache and set version constraints
  Future<void> addDependency() async {
    const retries = 2;
    for (int i = 0; i < retries; i++) {
      try {
        CachePackage(templatePackageName, projectDir);
        if (boolArg('pub')!) {
          try {
            await FlutterCli.pubGet(directory: projectDir);
          } catch (e) {
            _logger.w('Unable to pub get in ${projectDir.path}');
          }
        }
        return;
      } catch (e) {
        await FlutterCli.pubAdd(
          '$templatePackageName:$atAppFlutterVersion',
          directory: projectDir,
        );
      }
    }

    _logger.e(
        'Unable to add $templatePackageName:$atAppFlutterVersion to the project.');
    _logger.i('Please try again later.');
    throw PackageException(templatePackageName);
  }
}
