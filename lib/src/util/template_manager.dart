import 'dart:io';

import 'package:args/args.dart';
import 'package:io/io.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;

import 'exceptions.dart';
import 'file/android_manager.dart';
import 'file/env_manager.dart';
import 'printer.dart';

import '../version.dart';
import 'cache_package.dart';

class TemplateManager {
  final AndroidManager androidManager;
  final EnvManager envFileManager;
  final Directory projectDir;
  final ArgResults argResults;
  final String name;

  CachePackage cachePackage;
  final Logger _logger;

  TemplateManager(this.name, this.projectDir, this.argResults, {Logger? logger})
      : _logger =
            logger ?? Logger(filter: ProductionFilter(), printer: Printer()),
        envFileManager = EnvManager(projectDir),
        androidManager = AndroidManager(projectDir),
        cachePackage = CachePackage(templatePackageName, projectDir);

  Future<void> generateTemplate() async {
    _logger.i('');
    _logger.i('Adding your configurations to the app...');

    List<Future> futures = [
      androidManager.update(),
      envFileManager.update(parseEnvArgs()),
    ];

    await Future.wait(futures);

    _logger.i('');
    _logger.i('Building your $name template...');

    String from = path.absolute(path.joinAll([
      cachePackage.baseUrl,
      'lib',
      'src',
      'templates',
      name,
    ]));

    String to = path.absolute(path.joinAll([
      projectDir.absolute.path,
      'lib',
    ]));
    try {
      await copyPath(from, to);
    } catch (_) {
      throw TemplateFileException();
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
