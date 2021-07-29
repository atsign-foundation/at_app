// @dart = 2.8

import 'dart:io';

import 'file_manager.dart';

class TemplateManager extends FileManager {
  File source;

  TemplateManager(Directory projectDir, String filename, String source)
      : source = FileManager.fileFromPath(source),
        super(projectDir, filename);

  Future<bool> copyTemplate() async {
    try {
      while (existsSync == false) {
        sleep(Duration(milliseconds: 500));
      }
      var sourceLines = await source.readAsLines();
      write(sourceLines);
    } catch (error) {
      print(error.toString());
      return false;
    }
    return true;
  }
}
