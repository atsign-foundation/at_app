import 'dart:io';

import '../../../constants/android_config.dart';
import '../../../models/template_service_base.dart';
import '../../../models/file_manager.dart';

class AppBuildGradleManager extends TemplateServiceBase with FileManager {
  final Map<String, dynamic> options;
  AppBuildGradleManager(Directory projectDir, {Map<String, dynamic>? options})
      : options = options ?? defaultAppBuildGradleOptions,
        super(projectDir) {
    initFile('android/app/build.gradle');
  }

  @override
  Future<bool> run() async {
    try {
      List<String> lines = await file.readAsLines();

      // Update minSdkVersion
      int index = lines.indexWhere((line) => line.contains('minSdkVersion'));

      var minSdkVersion = options['minSdkVersion'] ?? defaultAppBuildGradleOptions['minSdkVersion'];
      var compileSdkVersion = options['compileSdkVersion'] ?? defaultAppBuildGradleOptions['compileSdkVersion'];
      var targetSdkVersion = options['targetSdkVersion'] ?? defaultAppBuildGradleOptions['targetSdkVersion'];

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
