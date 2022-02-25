import 'dart:io';

import '../models/file_manager.dart';

class EnvManager with FileManager {
  EnvManager(Directory projectDir, {required this.environment}) {
    initFile(projectDir.absolute.path);
  }

  @override
  final String filePath = '.env';

  final Map<String, String> environment;

  Future<void> run() async {
    try {
      await create();
      List<String> newFileContents = (await file.readAsLines()).map((line) {
        if (line.isNotEmpty && line.contains('=')) {
          String key = line.split('=')[0];
          if (environment.keys.contains(key)) {
            return '$key=${environment[key]}';
          }
        }
        return line;
      }).toList();

      for (String key in environment.keys) {
        if (!newFileContents.any((line) => line.startsWith(key))) {
          newFileContents.add('$key=${environment[key]}');
        }
      }

      await write(newFileContents);
    } catch (error) {
      throw Exception('Unable to configure environment in $filePath');
    }
  }
}
