import 'package:json_annotation/json_annotation.dart';
import 'package:pub_semver/pub_semver.dart';

import '../../models/models.dart';

part 'android_vars.g.dart';

@JsonSerializable()
class AndroidVars implements AtVars {
  /// The Flutter projectName
  String? projectName;

  /// The domain name part of the org name
  String? orgDomainName;

  /// The top level domain part of the org name
  String? orgTld;

  /// The minSdkVersion in app/build.gradle
  String? minSdkVersion;

  /// The targetSdkVersion in app/build.gradle
  String? targetSdkVersion;

  /// The compileSdkVersion in app/build.gradle
  String? compileSdkVersion;

  /// android.enableR8 in gradle.properties
  bool? enableR8;

  /// The ext.kotlin_version string in build.gradle
  @JsonKey(fromJson: _versionFromJson, toJson: _versionToJson)
  Version? kotlinVersion;

  ///The gradleVersion in gradle/wrapper
  String? gradleVersion;

  AndroidVars({
    this.projectName,
    this.orgTld,
    this.orgDomainName,
    this.minSdkVersion,
    this.targetSdkVersion,
    this.compileSdkVersion,
    this.enableR8,
    this.kotlinVersion,
    this.gradleVersion,
  });

  factory AndroidVars.fromJson(Map<String, dynamic> json) => _$AndroidVarsFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    validate();
    return _$AndroidVarsToJson(this);
  }

  @override
  void validate() {
    if (projectName == null) throw Exception();
    orgTld ??= 'com';
    orgDomainName ??= 'example';
    minSdkVersion ??= 'flutter.minSdkVersion';
    targetSdkVersion ??= 'flutter.targetSdkVersion';
    compileSdkVersion ??= 'flutter.compileSdkVersion';
    enableR8 ??= true;
    kotlinVersion ??= Version(1, 3, 50);
    gradleVersion ??= '6.7';
  }

  static Version? _versionFromJson(String json) {
    return Version.parse(json);
  }

  static String? _versionToJson(Version? version) {
    return version?.toString();
  }
}
