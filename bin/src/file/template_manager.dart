// @dart = 2.8

import 'dart:io';

import 'file_manager.dart';

class TemplateManager extends FileManager {
  File source;

  TemplateManager(Directory projectDir, String filename, String source)
      : source = FileManager.fileFromPath(source),
        super(projectDir, filename);

  Future<bool> copyTemplate() async {
    IOSink sink;
    try {
      while (existsSync == false) {
        sleep(Duration(milliseconds: 500));
      }
      var sourceLines = await source.readAsLines();
      sink = file.openWrite(mode: FileMode.writeOnly);
      sink.writeAll(sourceLines, '\n');
      await sink.flush();
    } catch (error) {
      if (sink != null) sink.close();
      print(error.toString());
      return false;
    }
    if (sink != null) sink.close();
    return true;
  }
}
