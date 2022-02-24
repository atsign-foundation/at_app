// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';
import 'package:pub_semver/pub_semver.dart';

import 'chit_chat_bundle.dart';

class ChitChatTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  ChitChatTemplateBundle() : super(chitChatBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'chit_chat'},
  dependencies: [
    "at_client_mobile: ^3.0.3",
    "at_utils: ^3.0.0",
    "path_provider: ^2.0.5",
    "flutter_dotenv: ^5.0.2",
    "at_chat_flutter: ^3.0.3",
    "at_contacts_flutter: ^4.0.0",
    "at_app_flutter: ^5.0.0"
  ],
  kotlinVersion: Version.parse('1.5.32'),
  minSdkVersion: '23',
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate chitChatTemplate = AtAppTemplate(
  name: 'chit_chat',
  description: 'Send end-to-end encrypted messages on the @platform!',
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
