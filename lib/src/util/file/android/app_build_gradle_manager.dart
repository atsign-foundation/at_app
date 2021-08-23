import 'dart:io';

import '../file_manager.dart';

class AppBuildGradleManager extends FileManager {
  AppBuildGradleManager(Directory projectDir)
      : super(projectDir, 'android/app/build.gradle');

  Future<bool> update() async {
    try {
      var lines = (await file.readAsLines()).map((line) {
        if (line.contains('minSdkVersion')) {
          return line.replaceFirst(
            RegExp('minSdkVersion .*'),
            'minSdkVersion 24',
          );
        }
        return line;
      }).toList();
      await write(lines);
    } catch (error) {
      print(error.toString());
      return false;
    }
    return true;
  }
}
