import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;

class CachePackage {
  String packageName;
  Directory projectDir;
  late Map<String, dynamic> packageInfo;

  CachePackage(this.packageName, this.projectDir) {
    File packageConfigFile = File(
      path.joinAll([
        projectDir.absolute.path,
        '.dart_tool',
        'package_config.json',
      ]),
    );

    packageInfo = jsonDecode(packageConfigFile.readAsStringSync())['packages']
        .firstWhere((package) => package['name'] as String == packageName);
  }

  Uri get rootUri => Uri.parse(packageInfo['rootUri']!);
  String get baseUrl => rootUri.toFilePath();
}
