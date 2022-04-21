import 'dart:io';
import 'package:meta/meta.dart';

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
      await (readAsLines().then(updateLines).then(addLines).then(write));
    } catch (error) {
      throw Exception('Unable to configure environment in $filePath');
    }
  }

  @visibleForTesting
  List<String> updateLines(List<String> lines) {
    return lines.map((line) {
      if (line.isNotEmpty && line.contains('=')) {
        String key = line.split('=')[0];
        if (environment.keys.contains(key)) {
          return '$key=${environment[key]}';
        }
      }
      return line;
    }).toList();
  }

  @visibleForTesting
  List<String> addLines(List<String> lines) {
    for (String key in environment.keys) {
      if (!lines.any((line) => line.startsWith(key))) {
        lines.add('$key=${environment[key]}');
      }
    }
    return lines;
  }
}
