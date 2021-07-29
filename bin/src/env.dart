// @dart = 2.8

import 'dart:io';

class EnvManager {
  File file;

  EnvManager(Directory projectDir)
      : file = File('${projectDir.absolute.path}/.env');

  Future<bool> get exists => file.exists();

  Future<bool> create() async {
    if (!await exists) {
      try {
        file = await file.create(recursive: true);
      } catch (error) {
        return false;
      }
    }
    return true;
  }

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
    } catch (error) {
      return false;
    }
    if (sink != null) sink.close();
    return true;
  }
}

Future<bool> updateValue(Directory projectDir, String key, String value) async {
  return true;
}
