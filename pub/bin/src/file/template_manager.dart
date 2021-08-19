// @dart = 2.8

import 'dart:io';

import 'package:pub_cache/pub_cache.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:flutter_tools/src/globals.dart' as globals;

import 'file_manager.dart';

class TemplateManager extends FileManager {
  File source;
  PubCache pc;
  String packageVersion;
  String hostedPubCachePath;

  TemplateManager(Directory projectDir, String filename, String source)
      : source = FileManager.fileFromPath(source),
        super(projectDir, filename) {
    pc = new PubCache();
    hostedPubCachePath = globals.fs.path
        .normalize('${pc.location.absolute.path}/hosted/pub.dartlang.org');
  }

  Future<bool> copyTemplate() async {
    try {
      while (existsSync == false) {
        sleep(Duration(milliseconds: 500));
      }
      if (!source.existsSync()) {
        setSourceFromPubCache();
      }
      var sourceLines = await source.readAsLines();
      await write(sourceLines);
    } catch (error) {
      print(error.toString());
      return false;
    }
    return true;
  }

  void setSourceFromPubCache() {
    Version version = pc.getLatestVersion('at_app').version;

    if (version == null) {
      throw NoPackageException('at_app');
    }

    source = FileManager.fileFromPath(
        '$hostedPubCachePath/at_app-${version.toString()}/lib/templates/main.dart');
  }
}

class NoPackageException extends Exception {
  factory NoPackageException(String packageName) =>
      Exception('No version of $packageName found in the pub cache.');
}
