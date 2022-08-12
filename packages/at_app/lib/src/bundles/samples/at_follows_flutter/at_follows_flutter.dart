// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';
import 'package:pub_semver/pub_semver.dart';

import 'at_follows_flutter_bundle.dart';

class AtFollowsFlutterTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  AtFollowsFlutterTemplateBundle() : super(atFollowsFlutterBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'at_follows_flutter'},
  dependencies: [
    "path_provider: ^2.0.11",
    "flutter_local_notifications: ^9.1.4",
    "at_app_flutter: ^5.0.1",
    "at_onboarding_flutter: ^5.0.0",
    "at_follows_flutter: ^3.0.7",
    "cupertino_icons: ^1.0.3"
  ],
  enableR8: true,
  kotlinVersion: Version.parse('1.5.32'),
  minSdkVersion: '24',
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate atFollowsFlutterTemplate = AtAppTemplate(
  name: 'at_follows_flutter',
  description: 'A sample of how to use the at_follows_flutter package',
  vars: _vars,
  overrideEnv: true,
  env: {"NAMESPACE": "productive2227", "API_KEY": "477b-876u-bcez-c42z-6a3d"},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    AtFollowsFlutterTemplateBundle(),
  ],
);
