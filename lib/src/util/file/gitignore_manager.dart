import 'dart:io';

import 'package:at_app/src/util/file/file_manager.dart';

class GitignoreManager extends FileManager {
  GitignoreManager(Directory projectDir) : super(projectDir, '.', '.gitignore');

  Future<bool> update() async {
    try {
      var lines = (await file.readAsLines());
      lines.addAll(['', '\.env']);
      await write(lines);
    } catch (_) {
      return false;
    }
    return true;
  }
}
