// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';
import 'package:pub_semver/pub_semver.dart';

import 'at_onboarding_flutter_bundle.dart';

class AtOnboardingFlutterTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  AtOnboardingFlutterTemplateBundle() : super(atOnboardingFlutterBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'at_onboarding_flutter'},
  dependencies: ["at_app_flutter: ^5.0.0"],
  kotlinVersion: Version.parse('1.5.32'),
  minSdkVersion: '23',
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate atOnboardingFlutterTemplate = AtAppTemplate(
  name: 'at_onboarding_flutter',
  description: 'A sample of how to use the at_onboarding_flutter package.',
  vars: _vars,
  overrideEnv: true,
  env: {"NAMESPACE": "productive2227", "API_KEY": "477b-876u-bcez-c42z-6a3d"},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    AtOnboardingFlutterTemplateBundle(),
  ],
);
