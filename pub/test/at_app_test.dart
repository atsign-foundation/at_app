// @dart=2.8
import 'package:pub_cache/pub_cache.dart';
import 'package:flutter_tools/src/globals.dart' as globals;
import 'dart:io';
import 'package:test/test.dart';

void main() {
  group('Template Manager', () {
    test('pub cache is found', () {
      String pubCachePath = PubCache().location.absolute.path;
      expect(pubCachePath.length > 0, true);
    });

    test('at_app is found in pub cache', () {
      PackageRef latest = PubCache().getLatestVersion('at_app');
      expect(latest == null, false);
    });

    test('main.dart template exists in the pub cache', () {
      PubCache pc = PubCache();
      String hostedPubCachePath = globals.fs.path
          .normalize('${pc.location.absolute.path}/hosted/pub.dartlang.org');

      String templatePath = globals.fs.path.join(
          hostedPubCachePath,
          'at_app-${pc.getLatestVersion('at_app')?.version.toString()}',
          'lib',
          'templates',
          'main.dart');

      File templateFile = File(templatePath);

      expect(templateFile.existsSync(), true);
    });
  });
}
