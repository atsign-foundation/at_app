// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';
import 'package:pub_semver/pub_semver.dart';

import 'at_backupkey_flutter_bundle.dart';

class AtBackupkeyFlutterTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  AtBackupkeyFlutterTemplateBundle() : super(atBackupkeyFlutterBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'at_backupkey_flutter'},
  dependencies: ["at_onboarding_flutter: ^4.0.0", "cupertino_icons: ^1.0.0"],
  enableR8: true,
  kotlinVersion: Version.parse('1.5.32'),
  minSdkVersion: '23',
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate atBackupkeyFlutterTemplate = AtAppTemplate(
  name: 'at_backupkey_flutter',
  description: 'A sample of how to use the at_backupkey_flutter package.',
  vars: _vars,
  overrideEnv: true,
  env: {"NAMESPACE": "productive2227", "API_KEY": "477b-876u-bcez-c42z-6a3d"},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    AtBackupkeyFlutterTemplateBundle(),
  ],
);
