import 'dart:io' show Directory;
import 'package:at_app/src/util/logger.dart';
import 'package:logger/logger.dart';

import '../../models/file_manager.dart';

class PubspecManager extends FileManager {
  PubspecManager(Directory projectDir) : super(projectDir, '.', 'pubspec.yaml');
  final Logger _logger = LoggerService().logger;

  Future<bool> update() async {
    try {
      List<String> lines = await file.readAsLines();

      // Assume 2 spaces per tab as is Flutter's default
      String tab = '  ';

      int flutterIndex = lines.indexWhere(
        (line) => line.startsWith('flutter:'),
      );

      if (flutterIndex < 0) {
        flutterIndex = lines.length;
        lines.add('flutter:');
        lines.add('');
      }

      int assetsIndex = lines.indexWhere(
        (line) => line.startsWith(RegExp(r'\s+assets:')),
        flutterIndex,
      );

      if (assetsIndex < 0) {
        assetsIndex = flutterIndex + 1;
        lines.insert(assetsIndex, '${tab}assets:');
      }

      int envIndex = lines.indexWhere(
        (line) => line.startsWith(RegExp(r'\s+-\s\.env')),
        assetsIndex,
      );

      if (envIndex < 0) {
        envIndex = assetsIndex + 1;
        lines.insert(envIndex, '$tab$tab- .env');
      }

      // Write the updated yaml as a string to the file
      await write(lines);
    } catch (_) {
      _logger.e('_ => ${_.toString()}');

      return false;
    }
    return true;
  }
}
