import 'dart:io' show Directory;

import '../../models/file_manager.dart';

class GitignoreManager extends FileManager {
  GitignoreManager(Directory projectDir) : super(projectDir, '.', '.gitignore');

  Future<bool> update() async {
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
