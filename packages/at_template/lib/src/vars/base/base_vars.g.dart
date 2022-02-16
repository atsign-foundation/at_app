// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_vars.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseVars _$BaseVarsFromJson(Map<String, dynamic> json) => BaseVars(
      projectName: json['projectName'] as String?,
      description: json['description'] as String?,
      dependencies: (json['dependencies'] as List<dynamic>?)?.map((e) => e as String).toList(),
      flutterConfig: (json['flutterConfig'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BaseVarsToJson(BaseVars instance) => <String, dynamic>{
      'projectName': instance.projectName,
      'description': instance.description,
      'dependencies': instance.dependencies,
      'flutterConfig': instance.flutterConfig,
    };
