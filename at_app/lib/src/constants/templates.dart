import 'package:at_app/src/bundles/bundles.dart';
import 'package:at_app/src/models/at_app_template.dart';
import 'package:at_template/at_template.dart';

const String defaultTemplateName = 'app';

Map<String, String> demoNames = {};

final List<AtTemplateBundle> defaultBundles = [AndroidTemplateBundle(), IosTemplateBundle(), BaseTemplateBundle()];

final List<AtAppTemplate> templates = [
  // Default App Template
  AtAppTemplate(
    defaultTemplateName,
    'The default @platform app template',
    [...defaultBundles, AppTemplateBundle()],
  ),
];

final List<AtAppTemplate> samples = [];

final List<AtAppTemplate> demos = [
  AtAppTemplate(
    'snackbar_sender',
    'Send snackbars to a flutter web application publically',
    [...defaultBundles, SnackbarSenderTemplateBundle()],
  ),
  AtAppTemplate(
    'snackbar',
    'Send and receive end to end encrypted snackbars',
    [...defaultBundles, SnackbarTemplateBundle()],
  ),
];
