import 'dart:io';

import 'package:at_app/src/models/exceptions/flutter_exception.dart';
import 'package:at_app/src/models/exceptions/template_exception.dart';
import 'package:at_app/src/services/template_generator.dart';

import '../util/logger.dart';

import '../util/namespace.dart';
import 'package:logger/logger.dart' show Logger;
import 'package:path/path.dart' show join, relative;

import '../cli/flutter_cli.dart';
import '../models/exceptions/cache_package_exception.dart';
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
      help: 'The @protocol app namespace to use for the application. (Use an @sign you own)',
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
    //
    argParser.addOption(
      'template-path',
      help: 'Template package path to override with for development',
      defaultsTo: null,
      valueHelp: 'path/to/package',
      hide: true,
    );
  }

  @override
  Future<CommandStatus> run() async {
    validateOutputDirectoryArg();

    validateEnvironment();

    /// These variables are for print formatting
    final bool creatingNewProject = !projectDir.existsSync() || projectDir.listSync().isEmpty;

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
      await cacheTemplatePackage(
        localPath: relative(
          argResults!['template-path'],
          from: projectDir.absolute.path,
        ),
      );

      /// Generate the template
      await TemplateGenerator(
        name: stringArg('template') ?? 'app',
        projectDir: projectDir,
        argResults: argResults!,
      ).generateTemplate();

      if (boolArg('pub')!) {
        await FlutterCli.pubGet(directory: projectDir);
      }
    } on TemplateException catch (e) {
      _logger.e('There was an issue generating part of your template:\n$e');
      return CommandStatus.fail;
    } on CachePackageException catch (e) {
      _logger.e('There was an issue pulling the templates from pub.dev:\n$e');
      return CommandStatus.fail;
    } on FlutterException catch (e) {
      _logger.e('There was an issue running pub get in $projectDir:\n$e');
      return CommandStatus.fail;
    } catch (e) {
      _logger.e('''An unknown issue occurred.
Please file a ticket to prevent this from happening again:
https://github.com/atsign-foundation/at_app''');
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
  Future<void> cacheTemplatePackage({String? localPath}) async {
    const maxTries = 2;

    for (int i = 0; i < maxTries; i++) {
      ProcessResult result = await _tryCachePackage(localPath);

      if (result.exitCode == 65 || result.exitCode == 0) return;

      _logger.w('Failed to retrieve the template package...\nWaiting 1 second before trying again');

      await Future.delayed(const Duration(seconds: 1));
    }

    throw CachePackageException(templatePackageName);
  }

  Future<ProcessResult> _tryCachePackage(String? localPath) async {
    return await FlutterCli.pubAdd(
      templatePackageName,
      directory: projectDir,
      localPath: localPath,
      // dev: true // TODO enable once template package is separated from at_app_flutter
    );
  }
}
