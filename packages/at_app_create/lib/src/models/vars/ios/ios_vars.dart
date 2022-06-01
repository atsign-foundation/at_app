import 'package:json_annotation/json_annotation.dart';

import '../../models.dart';

part 'ios_vars.g.dart';

@JsonSerializable()
class IosVars implements AtVars {
  /// The Flutter projectName
  String? projectName;

  /// The domain name part of the org name
  String? orgDomainName;

  /// The top level domain part of the org name
  String? orgTld;

  /// The minimum ios version
  String? minIosVersion;

  IosVars({
    required this.projectName,
    required this.orgDomainName,
    required this.orgTld,
    required this.minIosVersion,
  });

  factory IosVars.fromJson(Map<String, dynamic> json) => _$IosVarsFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    if (projectName == null) throw Exception('Project Name is null');
    return _$IosVarsToJson(this);
  }
}
