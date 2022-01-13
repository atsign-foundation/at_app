import 'package:json_annotation/json_annotation.dart';

import '../../models/models.dart';

part 'ios_vars.g.dart';

@JsonSerializable()
class IosVars implements AtVars {
  /// The Flutter projectName
  String? projectName;

  /// The domain name part of the org name
  String? orgDomainName;

  /// The top level domain part of the org name
  String? orgTld;

  IosVars({
    required this.projectName,
    required this.orgDomainName,
    required this.orgTld,
  });

  factory IosVars.fromJson(Map<String, dynamic> json) => _$IosVarsFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IosVarsToJson(this);

  @override
  void validate() {}

  @override
  void setDefaultValues() {}
}
