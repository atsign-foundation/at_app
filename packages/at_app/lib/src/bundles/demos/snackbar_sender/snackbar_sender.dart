// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';

import 'snackbar_sender_bundle.dart';

class SnackbarSenderTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  SnackbarSenderTemplateBundle() : super(snackbarSenderBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'snackbar_sender'},
  dependencies: [
    "at_client_mobile: ^3.2.6",
    "at_utils: ^3.0.11",
    "path_provider: ^2.0.11",
    "flutter_dotenv: ^5.0.2",
    "at_app_flutter: ^5.0.1",
    "at_onboarding_flutter: ^5.0.3",
    "biometric_storage: ^4.1.3"
  ],
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate snackbarSenderTemplate = AtAppTemplate(
  name: 'snackbar_sender',
  description: 'Send snackbars to a flutter web application publically.',
  vars: _vars,
  overrideEnv: true,
  env: {"NAMESPACE": "fourballcorporate9", "API_KEY": "477b-876u-bcez-c42z-6a3d"},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    SnackbarSenderTemplateBundle(),
  ],
);
