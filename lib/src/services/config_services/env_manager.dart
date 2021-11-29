import 'dart:io' show Directory;

import '../../models/file_manager.dart';

class EnvManager extends FileManager {
  EnvManager(Directory projectDir) : super(projectDir, '.', '.env');

  Future<bool> update(Map<String, String> values) async {
    try {
      await create();
      List<String> newFileContents = (await file.readAsLines()).map((line) {
        if (line.isNotEmpty && line.contains('=')) {
          String key = line.split('=')[0];
          if (values.keys.contains(key)) {
            return '$key=${values[key]}';
          }
        }
        return line;
      }).toList();

      for (String key in values.keys) {
        if (!newFileContents.any((line) => line.startsWith(key))) {
          newFileContents.add('$key=${values[key]}');
        }
      }

      await write(newFileContents);
    } catch (error) {
      return false;
    }
    return true;
  }
}
