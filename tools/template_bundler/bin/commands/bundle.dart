// ignore_for_file: implementation_imports, overridden_fields
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import '../template_yaml_parser.dart';
import 'package:mason/mason.dart';
import 'package:mason_cli/src/commands/bundle.dart';
import 'package:path/path.dart' as path;

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
    // todo log $bundlePath generated
    return masonResult ?? 0;
  }

  Future<void> _generateFiles(Directory brick, MasonBundle bundle, Map<String, dynamic> templateConfig) async {
    String dirName = path.basename(brick.absolute.path);

    File varFile = File(path.join(outputDir!, '$dirName.dart'));
    File bundleFile = File(path.join(outputDir!, '${dirName}_template_bundle.dart'));

    String className = '${bundle.name.pascalCase()}TemplateBundle';
    String varName = '${bundle.name.camelCase()}Template';

    String parsedVars = _parseVars(bundle, templateConfig);

    bool includePubSemver = parsedVars.contains('kotlinVersion');

    await varFile.create(recursive: true);

    List<String> varFileLines = await varFile.readAsLines();
    String lockLine = varFileLines.firstWhere(
      (element) => element.startsWith('// LOCKED ='),
      orElse: () => 'FALSE', // Unlocked by default (to write when empty)
    );

    if (!lockLine.contains(RegExp('true', caseSensitive: false))) {
      await varFile.writeAsString(
          "// GENERATED CODE - MODIFY AS NECESSARY\n// PREVENT OVERWRITING THIS FILE BELOW:\n// LOCKED = FALSE\n\nimport 'package:at_template/at_template.dart';\nimport 'package:at_app/src/models/at_app_template.dart';${(includePubSemver) ? "\nimport 'package:pub_semver/pub_semver.dart';" : ''}\n\nimport '${dirName}_template_bundle.dart';\n\nexport '${dirName}_template_bundle.dart';\n\nfinal $varName = AtAppTemplate(\n  name: '${bundle.name}',\n  description: '${bundle.description}',\n  vars: $parsedVars\n  bundles: [BaseTemplateBundle(), AndroidTemplateBundle(), IosTemplateBundle(), $className()],\n);");
    }

    await bundleFile.create(recursive: true);

    await bundleFile.writeAsString(
      "// GENERATED CODE - DO NOT MODIFY BY HAND\n\nimport 'package:at_template/at_template.dart';\nimport '${bundle.name}_bundle.dart';\n\nclass $className extends AtTemplateBundle<AtTemplateVars> {\n  $className() : super(${bundle.name.camelCase()}Bundle);\n}",
    );
  }

  String _parseVars(MasonBundle bundle, Map<String, dynamic> templateConfig) {
    List<String> result = ["AtTemplateVars(", "  includeBundles: {'${bundle.name}'},"];
    List<String> flutterConfig = [];

    if (templateConfig['env']['include'] ?? false || templateConfig['env']['override'] ?? false) {
      flutterConfig.addAll(['assets:', '  - .env']);
    }

    if ((templateConfig['dependencies'] as List<String>).isNotEmpty) {
      result.add("  dependencies: ${jsonEncode(templateConfig['dependencies'])},");
    }
    Map<String, dynamic> android = templateConfig['android'];
    if (android.isNotEmpty) {
      android.forEach((key, value) {
        switch (key) {
          case 'enableR8':
            result.add("  $key: $value,");
            break;
          case 'kotlinVersion': // pub_semver Version object
            result.add("  $key: Version.parse('$value'),");
            break;
          default: // String value
            result.add("  $key: '$value',");
        }
      });
    }

    result.add("  flutterConfig: ${jsonEncode(flutterConfig)},");
    result.add('),');
    if (templateConfig['env']['override'] ?? false) {
      result.add('overrideEnv: true,');
      result.add("env: ${jsonEncode(templateConfig['env_override'])},");
    }
    return result.join('\n  ');
  }

  String? get outputDir => argResults?['output-dir'];
}

class _BundleCommandRunner extends CommandRunner<int> {
  _BundleCommandRunner() : super('bundler', 'internal bundler used by AtBundleCommand') {
    addCommand(BundleCommand());
  }
}

extension _StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String uncapitalize() {
    return "${this[0].toLowerCase()}${substring(1).toLowerCase()}";
  }

  String camelCase() {
    List<String> parts = split('_');

    if (parts.isEmpty) {
      return '';
    }

    String first = parts[0].uncapitalize();
    List<String> rest = parts.sublist(1).map((String x) => x.capitalize()).toList();

    return first + rest.join('');
  }

  String pascalCase() {
    List<String> parts = split('_');

    if (parts.isEmpty) {
      return '';
    }

    return parts.map((String x) => x.capitalize()).toList().join('');
  }
}
