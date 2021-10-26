import 'dart:io';

import 'package:args/args.dart' show ArgResults;
import 'package:at_app/src/util/file/pubspec_manager.dart';
import 'package:io/io.dart' show copyPath;
import 'package:logger/logger.dart' show Logger, ProductionFilter;
import 'package:path/path.dart' show absolute, join;

import '../version.dart';
import 'cache_package.dart';
import 'exceptions/env_exception.dart';
import 'exceptions/template_exception.dart';
import 'file/android_manager.dart';
import 'file/env_manager.dart';
import 'file/gitignore_manager.dart';
import 'printer.dart';

class TemplateManager {
  // File Managers
  final AndroidManager androidManager;
  final EnvManager envFileManager;
  final GitignoreManager gitignoreManager;
  final PubspecManager pubspecManager;

  final Directory projectDir;
  final ArgResults argResults;
  final String name;

  CachePackage cachePackage;
  Logger _logger;

  TemplateManager(this.name, this.projectDir, this.argResults, {Logger? logger})
      : _logger =
            logger ?? Logger(filter: ProductionFilter(), printer: Printer()),
        envFileManager = EnvManager(projectDir),
        androidManager = AndroidManager(projectDir),
        gitignoreManager = GitignoreManager(projectDir),
        pubspecManager = PubspecManager(projectDir),
        cachePackage = CachePackage(templatePackageName, projectDir);

  Future<void> generateTemplate() async {
    _logger.i('');
    _logger.i('Adding your configurations to the app...');

    List<Future> futures = [
      androidManager.update(),
      envFileManager.update(parseEnvArgs()),
      gitignoreManager.update(),
      pubspecManager.update(),
    ];

    await Future.wait(futures);

    _logger.i('');
    _logger.i('Building your $name template...');

    String from = absolute(join(
      cachePackage.baseUrl,
      'lib',
      'src',
      'templates',
      name,
    ));

    String to = absolute(join(
      projectDir.absolute.path,
      'lib',
    ));
    try {
      await copyPath(from, to);
    } catch (_) {
      throw TemplateException();
    }
  }

  /// Updates the environment variables from the command arguments
  Future<void> updateEnvFile() async {
    try {
      var values = parseEnvArgs();
      await envFileManager.update(values);
    } catch (_) {
      throw EnvException();
    }
  }

  /// Parses the environment variables from the command arguments
  Map<String, String> parseEnvArgs() {
    Map<String, String> result = {};
    if (argResults.wasParsed('namespace')) {
      result['NAMESPACE'] = argResults['namespace'] as String;
    }
    if (argResults.wasParsed('root-domain')) {
      result['ROOT_DOMAIN'] =
          getRootDomain(argResults['root-domain'] as String);
    }
    if (argResults.wasParsed('api-key')) {
      result['API_KEY'] = argResults['api-key'] as String;
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
}
