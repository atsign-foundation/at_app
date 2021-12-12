import 'dart:io' show Directory;

import 'package:at_app/src/models/template_file_manager_base.dart';

class GitignoreManager extends FileTemplateServiceBase {
  GitignoreManager(Directory projectDir) : super(projectDir);

  @override
  final String filePath = '.gitignore';

  @override
  Future<bool> run() async {
    try {
      var lines = (await file.readAsLines());
      if (!lines.contains('.env')) {
        lines.addAll(['', '.env']);
      }
      await write(lines);
    } catch (_) {
      return false;
    }
    return true;
  }
}
