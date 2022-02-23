import 'package:json_annotation/json_annotation.dart';

import '../../models/models.dart';

part 'base_vars.g.dart';

@JsonSerializable()
class BaseVars implements AtVars {
  /// The Flutter projectName
  String? projectName;

  /// The Flutter project description
  String? description;

  /// A yaml map of the flutter dependencies
  /// Formatted lines as they would appear in pubspec.yaml
  /// The map under 'dependencies:' in pubspec.yaml

  List<String>? dependencies;

  /// A yaml map of the flutter config
  /// Formatted lines as they would appear in pubspec.yaml
  /// The map under 'flutter:' in pubspec.yaml
  List<String>? flutterConfig;

  /// Additional glob patterns to include in the .gitignore
  List<String>? gitignore;

  BaseVars({
    this.projectName,
    this.description,
    this.dependencies,
    this.flutterConfig,
    this.gitignore,
  });

  factory BaseVars.fromJson(Map<String, dynamic> json) => _$BaseVarsFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    if (projectName == null) throw Exception('Project Name is null');
    return _$BaseVarsToJson(this);
  }
}
