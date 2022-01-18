import 'package:at_template/at_template.dart';
import 'package:pub_semver/pub_semver.dart';

import '../bundles/bundles.dart';
import '../models/at_app_template.dart';
import 'templates.dart';

const List<String> _flutterConfig = ['assets:', '  -.env'];
const Map<String, String> _env = {
  'NAMESPACE': 'fourballcorporate9',
  'API_KEY': '477b-876u-bcez-c42z-6a3d',
};
Version _kotlinVersion = Version(1, 4, 31);
const List<String> _dependencies = [
  'at_client_mobile: ^3.0.3'
      'at_onboarding_flutter: ^3.0.1'
      'at_utils: ^3.0.0'
      'path_provider: ^2.0.5'
      'flutter_dotenv: ^5.0.2'
      'at_app_flutter: ^4.0.1'
];

List<AtAppTemplate> snackbarApps = [
  AtAppTemplate(
    name: 'snackbar',
    description: 'Send and receive end to end encrypted snackbars',
    vars: AtTemplateVars(
      flutterConfig: _flutterConfig,
      kotlinVersion: _kotlinVersion,
      dependencies: [..._dependencies, 'timer_builder: ^2.0.0'],
    ),
    overrideEnv: true,
    env: _env,
    bundles: [...defaultBundles, SnackbarTemplateBundle()],
  ),
  AtAppTemplate(
    name: 'snackbar_sender',
    description: 'Send snackbars to a flutter web application publically',
    vars: AtTemplateVars(
      flutterConfig: _flutterConfig,
      kotlinVersion: _kotlinVersion,
      dependencies: _dependencies,
    ),
    overrideEnv: true,
    env: _env,
    bundles: [...defaultBundles, SnackbarSenderTemplateBundle()],
  ),
];
