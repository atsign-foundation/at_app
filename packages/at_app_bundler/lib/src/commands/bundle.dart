// ignore_for_file: implementation_imports, overridden_fields
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:at_app_bundler/src/bundles/at_template_bundle/at_template_bundle_bundle.dart';
import '../util/template_yaml_parser.dart';
import 'package:mason/mason.dart';
import 'package:mason_cli/src/commands/bundle.dart';

class AtBundleCommand extends Command<int> {
  AtBundleCommand() {
    argParser.addOption(
      'output-dir',
      abbr: 'o',
      defaultsTo: '.',
      help: 'Directory where to output the generated template.',
    );
  }

  @override
  final String name = 'bundle';
  @override
  final String description = 'generates an at_template from a mason template';

  @override
  Future<int> run() async {
    if (argResults!.rest.isEmpty) {
      throw UsageException('path to the template must be provided', usage);
    }
    // First run mason bundle
    int? masonResult =
        await _BundleCommandRunner().run(['bundle', '-t', 'dart', '-o', outputDir ?? '.', argResults!.rest.first]);

    // Do template magic here
    Directory brick = Directory(argResults!.rest.first);
    MasonBundle bundle = createBundle(brick);
    TemplateYamlParser parser = TemplateYamlParser(brick);

    Map<String, dynamic> templateConfig = await parser.parse();
    await _generateFiles(brick, bundle, templateConfig);

    return masonResult ?? 0;
  }

  Future<void> _generateFiles(Directory brick, MasonBundle bundle, Map<String, dynamic> templateConfig) async {
    List<String>? additionalImports;

    bool includePubSemver = templateConfig['android']?.containsKey('kotlinVersion') ?? false;
    if (includePubSemver) {
      additionalImports ??= [];
      additionalImports.add("import 'package:pub_semver/pub_semver.dart';");
    }

    Map<String, dynamic> templateVars = {
      'name': bundle.name,
      'description': bundle.description,
      'additionalImports': additionalImports,
      'additionalVars': _parseVars(bundle, templateConfig),
      'overrideEnv': templateConfig['env']['override'] ?? false,
      'env': jsonEncode(templateConfig['env_override']),
    };

    MasonGenerator generator = await MasonGenerator.fromBundle(atTemplateBundleBundle);
    DirectoryGeneratorTarget target = DirectoryGeneratorTarget(Directory(outputDir!));
    await generator.generate(target, vars: templateVars, fileConflictResolution: FileConflictResolution.overwrite);
  }

  List<String>? _parseVars(MasonBundle bundle, Map<String, dynamic> templateConfig) {
    List<String> result = [];
    List<String> flutterConfig = [];

    List<String>? dependencies = templateConfig['dependencies'];
    Map<String, dynamic>? android = templateConfig['android'];
    List<String>? gitignore = templateConfig['gitignore'];

    if ((templateConfig['env']['include'] ?? false) || (templateConfig['env']['override'] ?? false)) {
      flutterConfig.addAll(['assets:', '  - .env']);
    }

    if (dependencies?.isNotEmpty ?? false) {
      result.add("dependencies: ${jsonEncode(dependencies)},");
    }

    if (android?.isNotEmpty ?? false) {
      android!.forEach((key, value) {
        switch (key) {
          case 'enableR8':
            result.add("$key: $value,");
            break;
          case 'kotlinVersion': // pub_semver Version object
            result.add("$key: Version.parse('$value'),");
            break;
          default: // String value
            result.add("$key: '$value',");
        }
      });
    }

    if (gitignore?.isNotEmpty ?? false) {
      result.add("gitignore: ${jsonEncode(gitignore)},");
    }

    if (flutterConfig.isNotEmpty) {
      result.add("flutterConfig: ${jsonEncode(flutterConfig)},");
    }

    if (result.isEmpty) return null;
    return result;
  }

  String? get outputDir => argResults?['output-dir'];
}

class _BundleCommandRunner extends CommandRunner<int> {
  _BundleCommandRunner() : super('bundler', 'internal bundler used by AtBundleCommand') {
    addCommand(BundleCommand());
  }
}
