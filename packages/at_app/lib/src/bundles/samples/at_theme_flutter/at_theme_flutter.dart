// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';

import 'at_theme_flutter_bundle.dart';

class AtThemeFlutterTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  AtThemeFlutterTemplateBundle() : super(atThemeFlutterBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'at_theme_flutter'},
  dependencies: [
    "at_common_flutter: ^2.0.8",
    "cupertino_icons: ^1.0.5",
    "at_theme_flutter: ^1.0.2",
    "at_app_flutter: ^5.0.1",
    "at_onboarding_flutter: ^5.0.0"
  ],
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate atThemeFlutterTemplate = AtAppTemplate(
  name: 'at_theme_flutter',
  description: 'A sample of how to use the at_theme_flutter package.',
  vars: _vars,
  overrideEnv: true,
  env: {"NAMESPACE": "productive2227", "API_KEY": "477b-876u-bcez-c42z-6a3d"},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    AtThemeFlutterTemplateBundle(),
  ],
);
