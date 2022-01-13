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

  BaseVars({
    this.projectName,
    this.description,
    this.dependencies,
    this.flutterConfig,
  });

  factory BaseVars.fromJson(Map<String, dynamic> json) => _$BaseVarsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BaseVarsToJson(this);

  @override
  void validate() {}

  @override
  void setDefaultValues() {}
}
