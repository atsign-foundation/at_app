import 'dart:io' show Directory;
import 'package:at_app/src/models/exceptions/template_exception.dart';
import 'package:at_app/src/util/local_path.dart';
import 'package:pubspec/pubspec.dart';

import '../../../models/template_service_base.dart';

class PubspecManager extends TemplateServiceBase {
  PubspecManager(
    Directory projectDir, {
    this.dependencies = const {},
    this.isLocal = false,
    bool? includeEnvFile,
  })  : includeEnvFile = includeEnvFile ?? false,
        super(projectDir);

  final Map<String, DependencyReference> dependencies;
  final bool includeEnvFile;
  final bool isLocal;

  @override
  Future<void> run() async {
    try {
      PubSpec pubSpec = await PubSpec.load(projectDir);

      Map<String, DependencyReference> workingDependencies = pubSpec.dependencies;
      Map<dynamic, dynamic> workingUnParsedYaml = pubSpec.unParsedYaml ?? {};
      Map<String, DependencyReference> dependencyOverrides = {};

      dependencies.forEach((key, value) {
        workingDependencies[key] = value;
      });

      if (includeEnvFile) {
        Map<dynamic, dynamic> workingFlutter = Map.from(workingUnParsedYaml['flutter'] ?? {});
        Set<dynamic> workingAssets = Set.from(workingFlutter['assets'] ?? {});
        workingAssets.add('.env');
        workingFlutter['assets'] = workingAssets.toList();
        workingUnParsedYaml['flutter'] = workingFlutter;
      }

      if (isLocal && workingDependencies.containsKey('at_app_flutter')) {
        dependencyOverrides['at_app_flutter'] = PathReference(getLocalPath('at_app_flutter', from: projectDir.path));
      }

      PubSpec newPubSpec = pubSpec.copy(
        dependencies: workingDependencies,
        unParsedYaml: workingUnParsedYaml,
        dependencyOverrides: dependencyOverrides,
      );

      await newPubSpec.save(projectDir);
    } catch (_) {
      throw TemplateException('Unable to update pubspec.yaml in the project.');
    }
  }
}
