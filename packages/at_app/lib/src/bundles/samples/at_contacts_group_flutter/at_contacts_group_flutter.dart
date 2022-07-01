// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';
import 'package:pub_semver/pub_semver.dart';

import 'at_contacts_group_flutter_bundle.dart';

class AtContactsGroupFlutterTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  AtContactsGroupFlutterTemplateBundle() : super(atContactsGroupFlutterBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'at_contacts_group_flutter'},
  dependencies: [
    "at_contacts_group_flutter: ^4.0.7",
    "cupertino_icons: ^1.0.5",
    "at_contacts_flutter: ^4.0.5",
    "at_app_flutter: ^5.0.0"
  ],
  enableR8: true,
  kotlinVersion: Version.parse('1.5.32'),
  minSdkVersion: '23',
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate atContactsGroupFlutterTemplate = AtAppTemplate(
  name: 'at_contacts_group_flutter',
  description: 'A sample of how to use the at_contacts_group_flutter package',
  vars: _vars,
  overrideEnv: true,
  env: {"NAMESPACE": "productive2227", "API_KEY": "477b-876u-bcez-c42z-6a3d"},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    AtContactsGroupFlutterTemplateBundle(),
  ],
);
