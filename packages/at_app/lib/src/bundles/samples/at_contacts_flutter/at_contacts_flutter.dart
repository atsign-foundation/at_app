// GENERATED CODE - MODIFY AS NECESSARY
// PREVENT OVERWRITING THIS FILE BELOW:
// LOCKED = FALSE

import 'package:at_template/at_template.dart';
import 'package:at_app/src/models/at_app_template.dart';
import 'package:pub_semver/pub_semver.dart';

import 'at_contacts_flutter_template_bundle.dart';

export 'at_contacts_flutter_template_bundle.dart';

final atContactsFlutterTemplate = AtAppTemplate(
  name: 'at_contacts_flutter',
  description: 'A sample of how to use the at_contacts_flutter package.',
  vars: AtTemplateVars(
    includeBundles: {'at_contacts_flutter'},
    dependencies: ["at_app_flutter: ^5.0.0", "at_contacts_flutter: ^4.0.0"],
    kotlinVersion: Version.parse('1.5.32'),
    minSdkVersion: '23',
    flutterConfig: ["assets:", "  - .env"],
  ),
  overrideEnv: true,
  env: {"NAMESPACE": "productive2227", "API_KEY": "477b-876u-bcez-c42z-6a3d"},
  bundles: [BaseTemplateBundle(), AndroidTemplateBundle(), IosTemplateBundle(), AtContactsFlutterTemplateBundle()],
);
