// @dart = 2.8
import 'dart:io';

import 'file_manager.dart';

class EnvManager extends FileManager {
  EnvManager(Directory projectDir, String filename)
      : super(projectDir, filename);

  Future<bool> update(Map<String, String> values) async {
    IOSink sink;
    try {
      await create();
      var newFileContents = (await file.readAsLines()).map((line) {
        if (line.isNotEmpty && line.contains('=')) {
          var key = line.split('=')[0];
          if (values.keys.contains(key)) {
            return '$key=${values[key]}';
          }
        }
        return line;
      }).toList();

      values.keys.forEach((key) {
        if (!newFileContents.any((line) => line.startsWith(key))) {
          newFileContents.add('$key=${values[key]}');
        }
      });

      sink = file.openWrite(mode: FileMode.writeOnly);
      sink.writeAll(newFileContents, '\n');
      await sink.flush();
    } catch (error) {
      if (sink != null) sink.close();
      return false;
    }
    if (sink != null) sink.close();
    return true;
  }
}
