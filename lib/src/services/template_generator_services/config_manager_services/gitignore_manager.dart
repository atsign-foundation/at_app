import 'dart:io' show Directory;

import '../../../models/template_service_base.dart';
import '../../../models/file_manager.dart';

class GitignoreManager extends TemplateServiceBase with FileManager {
  GitignoreManager(Directory projectDir) : super(projectDir) {
    initFile();
  }

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
