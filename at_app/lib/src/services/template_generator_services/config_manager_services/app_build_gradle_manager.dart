import 'dart:io';

import 'package:at_app/src/models/exceptions/template_exception.dart';
import 'package:at_app/src/models/template_file_manager_base.dart';

import '../../../constants/android_config.dart';

const filePath = 'android/app/build.gradle';

class AppBuildGradleManager extends FileTemplateServiceBase {
  final Map<String, dynamic> options;

  AppBuildGradleManager(Directory projectDir, {Map<String, dynamic>? options})
      : options = options ?? defaultAppBuildGradleOptions,
        super(projectDir);

  @override
  final String filePath = 'android/app/build.gradle';

  @override
  Future<void> run() async {
    try {
      List<String> lines = await file.readAsLines();

      for (String key in defaultAppBuildGradleOptions.keys) {
        var value = options[key] ?? defaultAppBuildGradleOptions[key];
        int index = lines.indexWhere((line) => line.contains(key));
        lines[index] = lines[index].replaceFirst(
          RegExp('$key.*'),
          _formatLine(key, value),
        );
      }

      await write(lines);
    } catch (_) {
      throw TemplateException('Unable to configure $filePath');
    }
  }

  String _formatLine(String key, dynamic value) {
    switch (key) {
      case 'ext.kotlin_version':
        return "$key='$value'";
      default:
        return '$key $value';
    }
  }
}
