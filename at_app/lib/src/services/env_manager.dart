import 'dart:io' show Directory;

import 'package:at_app/src/models/exceptions/template_exception.dart';
import 'package:at_app/src/models/template_file_manager_base.dart';

class EnvManager extends FileTemplateServiceBase {
  EnvManager(Directory projectDir, {required this.environment}) : super(projectDir);

  @override
  final String filePath = '.env';

  final Map<String, String> environment;

  @override
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
      throw TemplateException('Unable to configure environment in $filePath');
    }
  }
}
