// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';
import 'package:pub_semver/pub_semver.dart';

import 'at_chat_flutter_bundle.dart';

class AtChatFlutterTemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  AtChatFlutterTemplateBundle() : super(atChatFlutterBundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'at_chat_flutter'},
  dependencies: ["cupertino_icons: ^1.0.2", "at_app_flutter: 4.0.0", "at_chat_flutter: "],
  enableR8: true,
  kotlinVersion: Version.parse('1.5.32'),
  minSdkVersion: '23',
  flutterConfig: ["assets:", "  - .env"],
);

final AtAppTemplate atChatFlutterTemplate = AtAppTemplate(
  name: 'at_chat_flutter',
  description: 'A sample of how to use the at_chat_flutter package.',
  vars: _vars,
  overrideEnv: true,
  env: {"NAMESPACE": "productive2227", "API_KEY": "477b-876u-bcez-c42z-6a3d"},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    AtChatFlutterTemplateBundle(),
  ],
);
