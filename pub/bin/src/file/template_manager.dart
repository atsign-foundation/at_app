// @dart = 2.8

import 'dart:io';

import 'package:pub_cache/pub_cache.dart';
import 'package:pub_semver/pub_semver.dart';

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
    hostedPubCachePath = '${pc.location}/hosted/pub.dartlang.org';
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
    List<Version> entries = pc
        .getAllPackageVersions('at_app')
        .map((element) => element.version)
        .toList();
    Version version;
    entries.forEach((element) {
      if (version == null || element > version) {
        version = element;
      }
    });
    source = FileManager.fileFromPath(
        '$hostedPubCachePath/at_app-${version.toString()}/lib/templates/main.dart');
  }
}
