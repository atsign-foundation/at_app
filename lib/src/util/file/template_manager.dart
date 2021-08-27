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

  TemplateManager(Directory projectDir, this.filename)
      : pc = PubCache(),
        super(projectDir, 'lib', 'main.dart');

  Future<bool> copyTemplate() async {
    try {
      setSourceFromPubCache();
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
    String? flutterRoot = Platform.environment['FLUTTER_ROOT'];

    if (version == null && (flutterRoot?.isNotEmpty ?? false)) {
      pc = PubCache(Directory(path.absolute(path.join(flutterRoot!,
          '.pub-cache')))); // set the directory to $FLUTTER_ROOT and try again

      version = pc.getLatestVersion(templatePackage)?.version;
    }
    if (version == null) throw NoPackageException(templatePackage);

    buildSourceUrlForVersion(version.toString());
  }

  void buildSourceUrlForVersion(String version) {
    source = FileManager.fileFromPath(
      path.absolute(
        path.joinAll([
          pc.location.absolute.path,
          'hosted',
          'pub.dartlang.org',
          '$templatePackage-$version',
          'lib',
          'src',
          'templates',
          '$filename',
        ]),
      ),
    );
  }
}

class NoPackageException implements Exception {
  final String message;

  NoPackageException(String packageName)
      : message = 'No version of $packageName found in the pub cache.';
}
