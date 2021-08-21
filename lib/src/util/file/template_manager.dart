import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:pub_cache/pub_cache.dart';
import 'package:pub_semver/pub_semver.dart';

import 'file_manager.dart';

const String templatePackage = 'at_app_flutter';

class TemplateManager extends FileManager {
  String filename;
  PubCache pc;

  File? source;
  late String hostedPubCachePath;

  TemplateManager(Directory projectDir, this.filename)
      : pc = PubCache(),
        super(projectDir, path.normalize('lib/$filename')) {
    hostedPubCachePath =
        path.normalize('${pc.location.absolute.path}/hosted/pub.dartlang.org');
  }

  Future<bool> copyTemplate() async {
    try {
      setSourceFromPubCache();
      while (existsSync == false) {
        sleep(Duration(milliseconds: 500));
      }
      if (!source!.existsSync()) {
        setSourceFromPubCache();
      }
      var sourceLines = await source!.readAsLines();
      await write(sourceLines);
    } catch (error) {
      print(error.toString());
      return false;
    }
    return true;
  }

  void setSourceFromPubCache() {
    Version? version = pc.getLatestVersion(templatePackage)?.version;

    if (version == null) {
      throw NoPackageException(templatePackage);
    }

    buildSourceUrlForVersion(version.toString());
  }

  void buildSourceUrlForVersion(String version) {
    source = FileManager.fileFromPath(path.normalize(
        '$hostedPubCachePath/$templatePackage-${version}/lib/templates/$filename'));
  }
}

class NoPackageException implements Exception {
  final String message;

  NoPackageException(String packageName)
      : message = 'No version of $packageName found in the pub cache.';
}
