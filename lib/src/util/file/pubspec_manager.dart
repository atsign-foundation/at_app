import 'dart:io' show Directory;

import 'config/pubspec_config.dart';
import 'file_manager.dart';

class PubspecManager extends FileManager {
  PubspecManager(Directory projectDir) : super(projectDir, '.', 'pubspec.yaml');

  Future<bool> update() async {
    try {
      List<String> lines = await file.readAsLines();
      int index = lines.indexWhere((line) => line.startsWith(assetsLine));

      // Use the indentation of the dependencies section
      // to create the '- .env' line with the correct indentation
      // Since addDependency is called before the templateManager in commands/create.dart
      // We can ensure there will be at least one dependency
      int dependencyIndex =
          lines.indexWhere((line) => line.startsWith(dependenciesLine));
      int indentSpaces = lines[dependencyIndex + 1].indexOf('-');
      String spaces = List.filled(indentSpaces, ' ').join();
      String envLine = '$spaces$envLineTrimmed';

      if (index < 0) {
        // If there's no assets section add it at the end:

        // ensure empty line before assets line
        if (lines.last.trim().isEmpty) lines.add('');
        lines.add(assetsLine);
        lines.add(envLine);
        lines.add('');
      } else {
        // If there is an assets section iterate over each item
        // To check for the '- .env' file
        int i = index + 1;
        bool envLineExists = false;
        while (lines[i].startsWith('$spaces-')) {
          if (lines[i].trim() == envLineTrimmed) {
            envLineExists = true;
            // if the line exists, ensure it has the correct spacing
            lines[i] = envLine;
            break;
          }
          i++;
        }
        // add the line right after 'assets:' if it doesn't exist
        if (!envLineExists) {
          lines.insert(index + 1, envLine);
        }
      }
      await write(lines);
    } catch (_) {
      return false;
    }
    return true;
  }
}
