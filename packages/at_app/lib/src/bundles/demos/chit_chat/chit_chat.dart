// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';

import 'chit_chat_bundle.dart';

class ChitChatTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  ChitChatTemplateBundle() : super(chitChatBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'chit_chat'},
  dependencies: [
    "at_client_mobile: ^3.2.9",
    "at_utils: ^3.0.13",
    "path_provider: ^2.0.11",
    "flutter_dotenv: ^5.0.2",
    "at_chat_flutter: ^3.0.8",
    "at_contacts_flutter: ^4.0.10",
    "at_app_flutter: ^5.1.1",
    "at_onboarding_flutter: ^6.1.0",
    "biometric_storage: ^5.0.0+3"
  ],
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate chitChatTemplate = AtAppTemplate(
  name: 'chit_chat',
  description: 'Send end-to-end encrypted messages on the atPlatform!',
  vars: _vars,
  overrideEnv: true,
  env: {"NAMESPACE": "tapiradded13", "API_KEY": "477b-876u-bcez-c42z-6a3d"},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    ChitChatTemplateBundle(),
  ],
);
