// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';
import 'package:pub_semver/pub_semver.dart';

import 'at_events_flutter_bundle.dart';

class AtEventsFlutterTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  AtEventsFlutterTemplateBundle() : super(atEventsFlutterBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'at_events_flutter'},
  dependencies: [
    "cupertino_icons: ^1.0.5",
    "at_app_flutter: ^5.0.0+1",
    "at_events_flutter: ^3.1.6",
    "at_onboarding_flutter: ^4.0.3"
  ],
  enableR8: true,
  kotlinVersion: Version.parse('1.5.32'),
  minSdkVersion: '24',
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate atEventsFlutterTemplate = AtAppTemplate(
  name: 'at_events_flutter',
  description: 'A sample of how to use the at_events_flutter package',
  vars: _vars,
  overrideEnv: true,
  env: {"NAMESPACE": "productive2227", "API_KEY": "477b-876u-bcez-c42z-6a3d"},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    AtEventsFlutterTemplateBundle(),
  ],
);
