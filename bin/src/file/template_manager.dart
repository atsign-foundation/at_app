// @dart = 2.8

import 'dart:io';

import 'package:version/version.dart';

import 'file_manager.dart';
import 'package:flutter_tools/src/base/platform.dart';
import 'package:flutter_tools/src/globals.dart' as globals;

class TemplateManager extends FileManager {
  File source;
  String hostedPubCachePath;
  String packageVersion;

  TemplateManager(Directory projectDir, String filename, String source)
      : source = FileManager.fileFromPath(source),
        super(projectDir, filename) {
    var platform = LocalPlatform();
    var pubCachePath = platform.environment['PUB_CACHE'];
    if (pubCachePath == null) {
      if (platform.isWindows) {
        pubCachePath = '${platform.environment['LOCALAPPDATA']}\\Pub\\Cache';
      } else {
        pubCachePath = '${platform.environment['HOME']}/.pub-cache';
      }
    }
    hostedPubCachePath = '$pubCachePath/hosted/pub.dartlang.org';
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
      print('Using main.dart from: ${source.path}');
      await write(sourceLines);
    } catch (error) {
      print(error.toString());
      return false;
    }
    return true;
  }

  void setSourceFromPubCache() {
    List<Version> entries = Directory(hostedPubCachePath)
        .listSync(recursive: false)
        .map((element) => globals.fs.path.split(element.path).last)
        .where((element) {
          print(element);
          return element.startsWith('at_app');
        })
        .map((element) => Version.parse(element.replaceFirst('at_app-', '')))
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
