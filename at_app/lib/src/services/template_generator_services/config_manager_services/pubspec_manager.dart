import 'dart:io' show Directory;
import 'package:at_app/src/models/exceptions/template_exception.dart';
import 'package:pubspec/pubspec.dart';

import '../../../models/template_service_base.dart';

class PubspecManager extends TemplateServiceBase {
  PubspecManager(
    Directory projectDir, {
    this.dependencies = const {},
    bool? includeEnvFile,
  })  : includeEnvFile = includeEnvFile ?? false,
        super(projectDir);

  final Map<String, DependencyReference> dependencies;
  final bool includeEnvFile;

  @override
  Future<void> run() async {
    try {
      PubSpec pubSpec = await PubSpec.load(projectDir);

      Map<String, DependencyReference> workingDependencies = pubSpec.dependencies;
      Map<dynamic, dynamic>? workingUnParsedYaml = pubSpec.unParsedYaml;

      dependencies.forEach((key, value) {
        workingDependencies[key] = value;
      });

      if (includeEnvFile) {
        workingUnParsedYaml ??= {};
        Set<dynamic> workingAssets = Set.from(workingUnParsedYaml['flutter'] ?? {});
        workingAssets.add('.env');
        workingUnParsedYaml['flutter']['assets'] = workingAssets.toList();
      }

      PubSpec newPubSpec = pubSpec.copy(
        dependencies: workingDependencies,
        unParsedYaml: workingUnParsedYaml,
      );

      await newPubSpec.save(projectDir);
    } catch (_) {
      throw TemplateException('Unable to update pubspec.yaml in the project.');
    }
  }
}
