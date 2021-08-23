import 'package:pub_cache/pub_cache.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:test/test.dart';

void main() {
  group('Template Manager', () {
    test('pub cache is found', () {
      String pubCachePath = PubCache().location.absolute.path;
      print('pubCachePath => ${pubCachePath}');
      expect(pubCachePath.length > 0, true);
    });

    test('at_app is found in pub cache', () {
      PackageRef? latest = PubCache().getLatestVersion('at_app');
      print('latest.version.toString() => ${latest?.version.toString()}');
      expect(latest == null, false);
    });

    test('main.dart template exists in the pub cache', () {
      PubCache pc = PubCache();
      String hostedPubCachePath = path
          .normalize('${pc.location.absolute.path}/hosted/pub.dartlang.org');

      print('hostedPubCachePath => ${hostedPubCachePath}');

      String templatePath = path.join(
          hostedPubCachePath,
          'at_app-${pc.getLatestVersion('at_app')?.version.toString()}',
          'lib',
          'templates',
          'main.dart');

      print('templatePath => ${templatePath}');

      File templateFile = File(templatePath);

      expect(templateFile.existsSync(), true);
    });
  });
}
