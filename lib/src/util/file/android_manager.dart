import 'dart:io' show Directory;

import '../exceptions/android_build_exception.dart';
import 'config/android_config.dart';
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
      List<String> lines = await file.readAsLines();

      // Update minSdkVersion
      int index = lines.indexWhere((line) => line.contains('minSdkVersion'));

      lines[index] = lines[index].replaceFirst(
        RegExp('minSdkVersion .*'),
        'minSdkVersion $minSdkVersion',
      );

      // Update compileSdkVersion
      index = lines.indexWhere((line) => line.contains('compileSdkVersion'));

      lines[index] = lines[index].replaceFirst(
        RegExp('compileSdkVersion .*'),
        'compileSdkVersion $compileSdkVersion',
      );

      // Update targetSdkVersion
      index = lines.indexWhere((line) => line.contains('targetSdkVersion'));

      lines[index] = lines[index].replaceFirst(
        RegExp('targetSdkVersion .*'),
        'targetSdkVersion $targetSdkVersion',
      );

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
      var lines = await file.readAsLines();
      int index = lines.indexWhere((element) => element.startsWith(androidR8));
      String androidR8Full = '$androidR8=$androidR8Value';
      if (index < 0) {
        lines.add(androidR8Full);
      } else {
        lines[index] = androidR8Full;
      }
      await write(lines);
    } catch (_) {
      return false;
    }
    return true;
  }
}
