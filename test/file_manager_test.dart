import 'package:at_app/src/util/file/file_manager.dart';
import 'package:pub_cache/pub_cache.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:test/test.dart';

void main() {
  const templatePackage = 'at_app_flutter';

  group('Template Manager', () {
    late PubCache pc;

    setUp(() => pc = PubCache());
    test('pub cache is found', () {
      String pubCachePath = pc.location.absolute.path;
      expect(pubCachePath.length > 0, true);
    });

    test('at_app is found in pub cache', () {
      PackageRef? latest = pc.getLatestVersion(templatePackage);
      expect(latest == null, false);
    });

    test('main.dart template exists in the pub cache', () {
      String hostedPubCachePath = path
          .normalize('${pc.location.absolute.path}/hosted/pub.dartlang.org');

      String templatePath = path.join(
          hostedPubCachePath,
          '$templatePackage-${pc.getLatestVersion(templatePackage)?.version.toString()}',
          'lib',
          'src',
          'templates',
          'main.dart');

      File templateFile = File(templatePath);

      expect(templateFile.existsSync(), true);
    });
  });
}
