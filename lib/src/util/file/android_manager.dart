import 'dart:io';

import 'package:at_app/src/util/exceptions.dart';

import 'file_manager.dart';

class AndroidManager {
  final Directory projectDir;

  AndroidManager(this.projectDir);

  Future<void> update() async {
    List<Future> futures = [
      AppBuildGradleManager(projectDir).update(),
      GradlePropertiesManager(projectDir).update()
    ];
    for (var element in (await Future.wait(futures))) {
      if (!element) {
        throw AndroidBuildException();
      }
    }
  }
}

class AppBuildGradleManager extends FileManager {
  AppBuildGradleManager(Directory projectDir)
      : super(projectDir, 'android/app', 'build.gradle');

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
    } catch (_) {
      return false;
    }
    return true;
  }
}

class GradlePropertiesManager extends FileManager {
  GradlePropertiesManager(Directory projectDir)
      : super(projectDir, 'android', 'gradle.properties');

  Future<bool> update() async {
    try {
      var properties = await file.readAsLines();
      properties
          .removeWhere((element) => element.startsWith('android.enableR8'));
      properties.add('android.enableR8=true');
      await write(properties);
    } catch (_) {
      return false;
    }
    return true;
  }
}
