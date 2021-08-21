import 'dart:io';

import '../file_manager.dart';

class GradlePropertiesManager extends FileManager {
  GradlePropertiesManager(Directory projectDir)
      : super(projectDir, 'android/gradle.properties');

  Future<bool> update() async {
    try {
      var properties = await file.readAsLines();
      properties
          .removeWhere((element) => element.startsWith('android.enableR8'));
      properties.add('android.enableR8=true');
      await write(properties);
    } catch (error) {
      print(error.toString());
      return false;
    }
    return true;
  }
}
