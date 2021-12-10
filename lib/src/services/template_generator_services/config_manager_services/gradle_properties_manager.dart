import 'dart:io';

import '../../../constants/android_config.dart';
import '../../../models/template_service_base.dart';
import '../../../models/file_manager.dart';

class GradlePropertiesManager extends TemplateServiceBase with FileManager {
  Map<String, dynamic> options;
  GradlePropertiesManager(Directory projectDir, {Map<String, dynamic>? options})
      : options = options ?? defaultGradlePropertiesOptions,
        super(projectDir) {
    initFile('android/gradle.properties');
  }

  @override
  Future<bool> run() async {
    try {
      var lines = await file.readAsLines();

      options.forEach((key, value) {
        int index = lines.indexWhere((element) => element.startsWith(key));
        String line = '$key=$value';
        if (index < 0) {
          lines.add(line);
        } else {
          lines[index] = line;
        }
      });

      await write(lines);
    } catch (_) {
      return false;
    }
    return true;
  }
}
