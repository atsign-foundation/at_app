// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'android_vars.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AndroidVars _$AndroidVarsFromJson(Map<String, dynamic> json) => AndroidVars(
      projectName: json['projectName'] as String?,
      orgTld: json['orgTld'] as String?,
      orgDomainName: json['orgDomainName'] as String?,
      minSdkVersion: json['minSdkVersion'] as String?,
      targetSdkVersion: json['targetSdkVersion'] as String?,
      compileSdkVersion: json['compileSdkVersion'] as String?,
      enableR8: json['enableR8'] as bool?,
      kotlinVersion: AndroidVars._versionFromJson(json['kotlinVersion'] as String),
      gradleVersion: json['gradleVersion'] as String?,
    );

Map<String, dynamic> _$AndroidVarsToJson(AndroidVars instance) => <String, dynamic>{
      'projectName': instance.projectName,
      'orgDomainName': instance.orgDomainName,
      'orgTld': instance.orgTld,
      'minSdkVersion': instance.minSdkVersion,
      'targetSdkVersion': instance.targetSdkVersion,
      'compileSdkVersion': instance.compileSdkVersion,
      'enableR8': instance.enableR8,
      'kotlinVersion': AndroidVars._versionToJson(instance.kotlinVersion),
      'gradleVersion': instance.gradleVersion,
    };
