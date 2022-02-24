// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';
import 'package:pub_semver/pub_semver.dart';

import 'snackbar_sender_bundle.dart';

class SnackbarSenderTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  SnackbarSenderTemplateBundle() : super(snackbarSenderBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'snackbar_sender'},
  dependencies: [
    "at_client_mobile: ^3.0.3",
    "at_utils: ^3.0.0",
    "path_provider: ^2.0.5",
    "flutter_dotenv: ^5.0.2",
    "at_app_flutter: ^5.0.0"
  ],
  kotlinVersion: Version.parse('1.5.32'),
  minSdkVersion: '23',
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
