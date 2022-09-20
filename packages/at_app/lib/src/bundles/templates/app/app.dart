// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';

import 'app_bundle.dart';

class AppTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  AppTemplateBundle() : super(appBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'app'},
  dependencies: [
    "at_client_mobile: ^3.1.17",
    "at_utils: ^3.0.10",
    "path_provider: ^2.0.5",
    "flutter_dotenv: ^5.0.2",
    "at_app_flutter: ^5.0.1",
    "at_onboarding_flutter: ^5.0.0"
  ],
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate appTemplate = AtAppTemplate(
  name: 'app',
  description: 'The @platform skeleton app template.',
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
