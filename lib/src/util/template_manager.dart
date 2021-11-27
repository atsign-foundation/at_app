import 'dart:io';

import 'package:args/args.dart' show ArgResults;
import 'package:at_app/src/services/logger.dart';
import 'package:io/io.dart' show copyPath;
import 'package:logger/logger.dart' show Logger;
import 'package:path/path.dart' show absolute, join;

import '../../version.dart';
import 'cache_package.dart';
import '../models/exceptions/env_exception.dart';
import '../models/exceptions/template_exception.dart';
import 'file/android_manager.dart';
import 'file/env_manager.dart';
import 'file/gitignore_manager.dart';
import 'file/pubspec_manager.dart';
import 'namespace.dart';

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
  final Logger _logger = LoggerService().logger;

  Map<String, String> environment = {};

  TemplateManager(this.name, this.projectDir, this.argResults)
      : envFileManager = EnvManager(projectDir),
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

    String fromBase = absolute(join(
      cachePackage.baseUrl,
      'lib',
      'src',
      'templates',
      name,
    ));

    String from = absolute(join(fromBase, 'lib'));
    String to = absolute(join(projectDir.absolute.path, 'lib'));

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
    if (argResults.wasParsed('namespace')) {
      environment['NAMESPACE'] = normalizeNamespace(
        argResults['namespace'] as String,
      );
    }
    if (argResults.wasParsed('root-domain')) {
      environment['ROOT_DOMAIN'] = getRootDomain(
        argResults['root-domain'] as String,
      );
    }
    if (argResults.wasParsed('api-key')) {
      environment['API_KEY'] = argResults['api-key'] as String;
    }
    return environment;
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
