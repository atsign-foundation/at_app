import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' show relative;
import 'package:pub_semver/pub_semver.dart';
import 'package:pubspec/pubspec.dart';
import 'package:yaml/yaml.dart';

import 'package:at_app/src/models/file_manager.dart';
import 'package:at_app/src/models/template_service_base.dart';
import 'package:at_app/src/util/namespace.dart';
import 'package:at_app/src/util/root_domain.dart';
import 'package:at_app/src/util/yaml.dart';
import 'package:at_app/version.dart';

import 'config_manager_services/app_build_gradle_manager.dart';
import 'config_manager_services/build_gradle_manager.dart';
import 'config_manager_services/env_manager.dart';
import 'config_manager_services/gitignore_manager.dart';
import 'config_manager_services/gradle_properties_manager.dart';
import 'config_manager_services/pubspec_manager.dart';

class ConfigManager extends TemplateServiceBase with FileManager {
  final String templatePath;
  final ArgResults argResults;
  final List<TemplateServiceBase> managers = [];
  late YamlMap yaml;

  ConfigManager({
    required Directory projectDir,
    required this.templatePath,
    required this.argResults,
  }) : super(projectDir) {
    initFile(templatePath);
    yaml = loadYamlDocument(file.readAsStringSync()).contents.value;
  }

  @override
  final String filePath = 'template.yaml';

  @override
  Future<void> run() async {
    Map<String, DependencyReference> dependencies = parseDependencies();
    Map<String, bool> envConfig = parseEnvConfig();
    Map<String, dynamic> androidConfig = parsePlatformConfig('android');

    bool envOverride = envConfig['override'] ?? false;
    bool includeEnv = (envConfig['include'] ?? false) || envOverride;

    // Check if we need to add a pubspec manager
    if (dependencies.isNotEmpty || includeEnv) {
      managers.add(
        PubspecManager(
          projectDir,
          dependencies: dependencies,
          includeEnvFile: includeEnv,
        ),
      );

      if (includeEnv) {
        Map<String, String> environment = (envOverride) ? parseEnvOverride() : parseEnvArgs();
        managers.add(EnvManager(projectDir, environment: environment));
      }
    }

    if (envConfig['gitignore'] ?? false) {
      managers.add(GitignoreManager(projectDir));
    }

    if (androidConfig['gradle.properties']?.isNotEmpty ?? false) {
      managers.add(GradlePropertiesManager(projectDir, options: androidConfig['gradle.properties']));
    }

    managers.add(AppBuildGradleManager(projectDir, options: androidConfig['app.build.gradle']));

    managers.add(BuildGradleManager(projectDir, options: androidConfig['build.gradle']));

    // Call the run function on each config_manager in parallel
    await Future.wait(managers.map((m) => m.run()));
  }

  Map<String, DependencyReference> parseDependencies() {
    Map<String, String?> parsed = YamlMapParser<String, String?>(yaml['dependencies'])?.toMap() ?? {};
    return parsed.map<String, DependencyReference>((key, value) {
      if (key == templatePackageName && argResults['template-path'] != null) {
        return MapEntry(
          key,
          PathReference(
            // The POSIX relative path of [template-path] from [projectDir]
            relative(
              argResults['template-path'],
              from: projectDir.absolute.path,
            ).replaceAll('\\', '/'),
          ),
        );
      }
      return MapEntry(key, HostedReference(VersionConstraint.parse(value ?? 'any')));
    });
  }

  Map<String, bool> parseEnvConfig() {
    Map<String, bool> parsed = YamlMapParser<String, bool>(yaml['config']?['env'])?.toMap() ?? {};

    for (String key in ['include', 'gitignore', 'override']) {
      if (!parsed.containsKey(key)) {
        parsed[key] = false;
      }
    }
    return parsed;
  }

  Map<String, Map<String, dynamic>> parsePlatformConfig(String platform) {
    List<dynamic> keys = yaml['config']?[platform]?.keys.toList() ?? [];
    Map<String, Map<String, dynamic>> parsed = {};
    for (String key in keys) {
      parsed[key] = YamlMapParser<String, dynamic>(yaml['config']?[platform]?[key])?.toMap() ?? {};
    }
    return parsed;
  }

  Map<String, String> parseEnvOverride() {
    return YamlMapParser<String, String>(yaml['config']?['env_override'])?.toMap() ?? {};
  }

  /// Parses the environment variables from the command arguments
  Map<String, String> parseEnvArgs() {
    Map<String, String> environment = {};
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
