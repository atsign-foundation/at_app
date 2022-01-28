// GENERATED CODE - MODIFY AS NECESSARY
// PREVENT OVERWRITING THIS FILE BELOW:
// LOCKED = FALSE

import 'package:at_template/at_template.dart';
import 'package:at_app/src/models/at_app_template.dart';

import 'chit_chat_template_bundle.dart';

export 'chit_chat_template_bundle.dart';

final chitChatTemplate = AtAppTemplate(
  name: 'chit_chat',
  description: 'Send end-to-end encrypted messages on the @platform!',
  vars: AtTemplateVars(
    includeBundles: {'chit_chat'},
    dependencies: ["at_client_mobile: ^3.0.3","at_onboarding_flutter: ^3.0.1","at_utils: ^3.0.0","path_provider: ^2.0.5","flutter_dotenv: ^5.0.2","at_chat_flutter: ^3.0.3","at_contacts_flutter: ^4.0.0","at_app_flutter: "],
    flutterConfig: ["assets:","  - .env"],
  ),
  overrideEnv: true,
  env: {"NAMESPACE":"tapiradded13","API_KEY":"400b-806u-bzez-z42z-6a3p"},
  bundles: [BaseTemplateBundle(), AndroidTemplateBundle(), IosTemplateBundle(), ChitChatTemplateBundle()],
);
