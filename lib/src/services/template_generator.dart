import 'dart:io';

import 'package:args/args.dart';
import 'package:at_app/src/models/cache_package.dart';
import 'package:at_app/version.dart';
import 'package:path/path.dart' show absolute, join;

import 'template_generator_services/config_manager.dart';
import 'template_generator_services/template_builder.dart';

class TemplateGenerator {
  final Directory projectDir;
  final ArgResults argResults;
  late String templatePath;

  TemplateGenerator({
    required name,
    required this.projectDir,
    required this.argResults,
  }) {
    /// Get the [templatePath] using the [CachePackage] model
    String baseUrl = argResults['template-path'] ?? CachePackage(templatePackageName, projectDir).baseUrl;
    templatePath = absolute(
      join(
        baseUrl,
        'lib',
        'src',
        'templates',
        name,
      ),
    );
  }

  Future<void> generateTemplate() async {
    TemplateBuilder templateService = TemplateBuilder(
      projectDir: projectDir,
      templatePath: templatePath,
    );

    ConfigManager configService = ConfigManager(
      projectDir: projectDir,
      templatePath: templatePath,
      argResults: argResults,
    );

    /// Run the [ConfigService] and [TemplateService] in parallel
    await Future.wait([templateService.run(), configService.run()]);
  }
}
