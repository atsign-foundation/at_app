import 'dart:io' show Directory;
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
  Future<bool> run() async {
    try {
      PubSpec pubSpec = await PubSpec.load(projectDir);

      Map<String, DependencyReference> workingDependencies = pubSpec.dependencies;
      Map<dynamic, dynamic>? workingUnParsedYaml = pubSpec.unParsedYaml;

      dependencies.forEach((key, value) {
        workingDependencies[key] = value;
      });

      if (includeEnvFile) {
        workingUnParsedYaml ??= {};
        Set<dynamic> workingAssets = Set.from(workingUnParsedYaml['assets'] ?? {});
        workingAssets.add('.env');
        workingUnParsedYaml['assets'] = workingAssets.toList();
      }

      PubSpec newPubSpec = pubSpec.copy(
        dependencies: workingDependencies,
        unParsedYaml: workingUnParsedYaml,
      );

      await newPubSpec.save(projectDir);
    } catch (_) {
      // TODO throw
    }
    return true;
  }
}
