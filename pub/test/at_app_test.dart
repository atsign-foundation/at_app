import 'package:pub_cache/pub_cache.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_tools/src/globals.dart' as globals;
import 'dart:io';

void main() {
  testTemplateManager();
}

void testTemplateManager() {
  PubCache pc = new PubCache();

  String pubCachePath = pc.location.absolute.path;
  assert(pubCachePath.length > 0);

  PackageRef? latest = pc.getLatestVersion('at_app');

  assert(latest != null);

  String hostedPubCachePath = globals.fs.path
      .normalize('${pc.location.absolute.path}/hosted/pub.dartlang.org');

  String templatePath = globals.fs.path.join(hostedPubCachePath,
      'at_app-${latest?.version.toString()}', 'lib', 'main.dart');

  File templateFile = File(templatePath);

  assert(templateFile.existsSync());
}
