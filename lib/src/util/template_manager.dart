import 'dart:io';

import 'package:args/args.dart';
import 'package:at_app/src/util/printer.dart';
import 'package:io/io.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'package:pub_cache/pub_cache.dart';

import 'package:at_app/src/util/exceptions.dart';
import 'package:at_app/src/util/file/android_manager.dart';
import 'package:at_app/src/util/file/env_manager.dart';
import 'package:pub_semver/pub_semver.dart';

import '../version.dart';

class TemplateManager {
  final AndroidManager androidManager;
  final EnvManager envFileManager;
  final Directory projectDir;
  final ArgResults argResults;
  final String name;

  Cache cache;
  Logger _logger;

  TemplateManager(this.name, this.projectDir, this.argResults, {Logger? logger})
      : _logger =
            logger ?? Logger(filter: ProductionFilter(), printer: Printer()),
        envFileManager = EnvManager(projectDir),
        androidManager = AndroidManager(projectDir),
        cache = Cache(templatePackageName, templatePackageVersion);

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
      cache.baseUrl,
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

class Cache {
  PubCache _pc = PubCache();
  String packageName;
  Version packageVersion;

  Cache(this.packageName, this.packageVersion) {
    String? flutterRoot = Platform.environment['FLUTTER_ROOT'];

    if (!versionExists() && (flutterRoot?.isNotEmpty ?? false)) {
      _pc = PubCache(Directory(path.absolute(path.join(flutterRoot!,
          '.pub-cache')))); // set the directory to $FLUTTER_ROOT and try again
    }

    if (!versionExists()) {
      throw NoPackageException;
    }
  }

  PubCache get pubCache => _pc;

  String get baseUrl => path.absolute(path.joinAll([
        _pc.location.absolute.path,
        'hosted',
        'pub.dartlang.org',
        '$packageName-$packageVersion',
      ]));

  bool versionExists() {
    return _pc
        .getAllPackageVersions(packageName)
        .map((e) => e.version)
        .contains(packageVersion);
  }
}
