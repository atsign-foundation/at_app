// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'at_template_vars.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtTemplateVars _$AtTemplateVarsFromJson(Map<String, dynamic> json) => AtTemplateVars(
      projectName: json['projectName'] as String?,
      description: json['description'] as String?,
      dependencies: (json['dependencies'] as List<dynamic>?)?.map((e) => e as String).toList(),
      flutterConfig: (json['flutterConfig'] as List<dynamic>?)?.map((e) => e as String).toList(),
      gitignore: (json['gitignore'] as List<dynamic>?)?.map((e) => e as String).toList(),
      orgTld: json['orgTld'] as String?,
      orgDomainName: json['orgDomainName'] as String?,
      minIosVersion: json['minIosVersion'] as String?,
      minSdkVersion: json['minSdkVersion'] as String?,
      targetSdkVersion: json['targetSdkVersion'] as String?,
      compileSdkVersion: json['compileSdkVersion'] as String?,
      enableR8: json['enableR8'] as bool?,
      kotlinVersion: AtTemplateVars._versionFromJson(json['kotlinVersion'] as String),
      gradleVersion: json['gradleVersion'] as String?,
    );

Map<String, dynamic> _$AtTemplateVarsToJson(AtTemplateVars instance) => <String, dynamic>{
      'projectName': instance.projectName,
      'description': instance.description,
      'dependencies': instance.dependencies,
      'flutterConfig': instance.flutterConfig,
      'gitignore': instance.gitignore,
      'orgDomainName': instance.orgDomainName,
      'orgTld': instance.orgTld,
      'minIosVersion': instance.minIosVersion,
      'minSdkVersion': instance.minSdkVersion,
      'targetSdkVersion': instance.targetSdkVersion,
      'compileSdkVersion': instance.compileSdkVersion,
      'enableR8': instance.enableR8,
      'kotlinVersion': AtTemplateVars._versionToJson(instance.kotlinVersion),
      'gradleVersion': instance.gradleVersion,
    };
