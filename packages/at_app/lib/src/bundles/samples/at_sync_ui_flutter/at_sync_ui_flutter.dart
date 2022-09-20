// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';

import 'at_sync_ui_flutter_bundle.dart';

class AtSyncUiFlutterTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  AtSyncUiFlutterTemplateBundle() : super(atSyncUiFlutterBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'at_sync_ui_flutter'},
  dependencies: [
    "at_app_flutter: ^5.0.1",
    "at_onboarding_flutter: ^5.0.0",
    "cupertino_icons: ^1.0.5",
    "flutter_colorpicker: ^1.0.3",
    "at_sync_ui_flutter: ^1.0.5"
  ],
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate atSyncUiFlutterTemplate = AtAppTemplate(
  name: 'at_sync_ui_flutter',
  description: 'A sample of how to use the at_sync_ui_flutter package.',
  vars: _vars,
  overrideEnv: true,
  env: {"NAMESPACE": "productive2227", "API_KEY": "477b-876u-bcez-c42z-6a3d"},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    AtSyncUiFlutterTemplateBundle(),
  ],
);
