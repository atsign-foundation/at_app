import 'package:at_app/src/util/cache_package.dart';
import 'package:at_app/src/util/template_manager.dart';
import 'package:at_app/src/version.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;

import 'command_status.dart';
import '../util/exceptions.dart';
import '../util/cli/flutter.dart';
import '../util/printer.dart';
import 'create_base.dart';

/// This class extends the flutter create abstraction,
/// It will pull templates from at_app_flutter
/// and uses the respective template generator to generate the full template.
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

    /// These variables are for print formatting
    final bool creatingNewProject =
        !projectDir.existsSync() || projectDir.listSync().isEmpty;

    final String relativeOutputPath = path.relative(projectDir.absolute.path);

    final String relativeAppMain =
        path.join(relativeOutputPath, 'lib', 'main.dart');

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
      _logger.e('Failed to setup the @platform configuration.');
      return CommandStatus.fail;
    } on TemplateFileException {
      _logger.e('Failed to transfer a template file.');
      return CommandStatus.fail;
    } on NoPackageException {
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

  /// Install at_app_flutter to pub cache and set version constraints
  Future<void> addDependency() async {
    const retries = 2;
    for (int i = 0; i < retries; i++) {
      try {
        CachePackage(templatePackageName, projectDir);
        if (boolArg('pub')!) {
          try {
            await Flutter.pubGet(directory: projectDir);
          } catch (e) {
            _logger.w('Unable to pub get in ${projectDir.path}');
          }
        }
        return;
      } catch (e) {
        await Flutter.pubAdd(
          '$templatePackageName:$templatePackageVersion',
          directory: projectDir,
        );
      }
    }

    _logger.e(
        'Unable to add $templatePackageName:$templatePackageVersion to the project.');
    _logger.i('Please try again later.');
    throw NoPackageException(templatePackageName);
  }
}
