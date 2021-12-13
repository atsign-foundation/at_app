import 'dart:io' show Directory;

import 'package:args/args.dart';
import 'package:at_app/src/models/exceptions/template_exception.dart';
import 'package:at_app/src/models/template_file_manager_base.dart';
import 'package:at_app/src/util/namespace.dart';
import 'package:at_app/src/util/root_domain.dart';

class EnvManager extends FileTemplateServiceBase {
  EnvManager(Directory projectDir, {required ArgResults argResults}) : super(projectDir) {
    _parseEnvArgs(argResults);
  }

  @override
  final String filePath = '.env';

  final Map<String, String> environment = {};

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

  /// Parses the environment variables from the command arguments
  Map<String, String> _parseEnvArgs(ArgResults argResults) {
    if (argResults.wasParsed('namespace')) {
      environment['NAMESPACE'] = normalizeNamespace(
        argResults['namespace'] as String,
      );
    }
    if (argResults.wasParsed('root-domain')) {
      environment['ROOT_DOMAIN'] = getRootDomain(
        argResults['root-domain'] as String,
      );
    }
    if (argResults.wasParsed('api-key')) {
      environment['API_KEY'] = argResults['api-key'] as String;
    }
    return environment;
  }
}
