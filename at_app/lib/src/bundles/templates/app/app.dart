// GENERATED CODE - MODIFY AS NECESSARY
// PREVENT OVERWRITING THIS FILE BELOW:
// LOCKED = FALSE

import 'package:at_template/at_template.dart';
import 'package:at_app/src/models/at_app_template.dart';

import 'app_template_bundle.dart';

export 'app_template_bundle.dart';

final appTemplate = AtAppTemplate(
  name: 'app',
  description: 'The @platform skeleton app template.',
  vars: AtTemplateVars(
    includeBundles: {'app'},
    dependencies: ["at_client_mobile: ^3.0.3","at_onboarding_flutter: ^3.0.1","at_utils: ^3.0.0","path_provider: ^2.0.5","flutter_dotenv: ^5.0.2","at_app_flutter: "],
    enableR8: true,
    flutterConfig: ["assets:","  - .env"],
  ),
  bundles: [BaseTemplateBundle(), AndroidTemplateBundle(), IosTemplateBundle(), AppTemplateBundle()],
);