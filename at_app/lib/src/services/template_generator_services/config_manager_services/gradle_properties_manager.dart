import 'dart:io';

import 'package:at_app/src/models/exceptions/template_exception.dart';
import 'package:at_app/src/models/template_file_manager_base.dart';

import '../../../constants/android_config.dart';

class GradlePropertiesManager extends FileTemplateServiceBase {
  Map<String, dynamic> options;
  GradlePropertiesManager(Directory projectDir, {Map<String, dynamic>? options})
      : options = options ?? defaultGradlePropertiesOptions,
        super(projectDir);

  @override
  final String filePath = 'android/gradle.properties';

  @override
  Future<void> run() async {
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
      throw TemplateException('Unable to update the gradle.properties file.');
    }
  }
}
