import 'package:at_template/at_template.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

import 'vars.dart';

part 'at_template_vars.g.dart';

@JsonSerializable()
class AtTemplateVars implements AndroidVars, BaseVars, IosVars {
  /// The Flutter projectName
  @override
  String? projectName;

  /// The Flutter project description
  @override
  String? description;

  /// A yaml map of the flutter dependencies
  /// Formatted lines as they would appear in pubspec.yaml
  /// The map under 'dependencies:' in pubspec.yaml

  @override
  List<String>? dependencies;

  /// A yaml map of the flutter config
  /// Formatted lines as they would appear in pubspec.yaml
  /// The map under 'flutter:' in pubspec.yaml
  @override
  List<String>? flutterConfig;

  /// The domain name part of the org name
  @override
  String? orgDomainName;

  /// The top level domain part of the org name
  @override
  String? orgTld;

  /// The minSdkVersion in app/build.gradle
  @override
  String? minSdkVersion;

  /// The targetSdkVersion in app/build.gradle
  @override
  String? targetSdkVersion;

  /// The compileSdkVersion in app/build.gradle
  @override
  String? compileSdkVersion;

  /// android.enableR8 in gradle.properties
  @override
  bool? enableR8;

  /// The ext.kotlin_version string in build.gradle
  @override
  @JsonKey(fromJson: _versionFromJson, toJson: _versionToJson)
  Version? kotlinVersion;

  ///The gradleVersion in gradle/wrapper
  @override
  String? gradleVersion;

  AtTemplateVars({
    this.projectName,
    this.description,
    this.dependencies,
    this.flutterConfig,
    this.orgTld,
    this.orgDomainName,
    this.minSdkVersion,
    this.targetSdkVersion,
    this.compileSdkVersion,
    this.enableR8,
    this.kotlinVersion,
    this.gradleVersion,
  });

  factory AtTemplateVars.fromJson(Map<String, dynamic> json) => _$AtTemplateVarsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AtTemplateVarsToJson(this);

  @override
  void validate() {}

  @override
  void setDefaultValues() {}

  static Version? _versionFromJson(String json) {
    return Version.parse(json);
  }

  static String? _versionToJson(Version? version) {
    return version?.toString();
  }
}
