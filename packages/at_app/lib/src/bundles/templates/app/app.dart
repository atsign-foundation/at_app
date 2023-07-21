// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';

import 'app_bundle.dart';

class AppTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  AppTemplateBundle() : super(appBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'app'},
  dependencies: [
    "at_client_mobile: ^3.2.6",
    "at_utils: ^3.0.11",
    "path_provider: ^2.0.11",
    "flutter_dotenv: ^5.0.2",
    "at_app_flutter: ^5.0.1",
    "at_onboarding_flutter: ^6.1.0",
    "biometric_storage: ^5.0.0"
  ],
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate appTemplate = AtAppTemplate(
  name: 'app',
  description: 'The atPlatform skeleton app template.',
  vars: _vars,
  overrideEnv: false,
  env: {},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    AppTemplateBundle(),
  ],
);
