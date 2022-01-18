import 'package:at_template/at_template.dart';

import '../bundles/bundles.dart';
import '../models/at_app_template.dart';
import 'snackbar.dart';

const String defaultTemplateName = 'app';

List<AtTemplateBundle> defaultBundles = [BaseTemplateBundle(), AndroidTemplateBundle(), IosTemplateBundle()];

final List<AtAppTemplate> templates = [
  AtAppTemplate(
    name: defaultTemplateName,
    description: 'The default @platform template',
    vars: AtTemplateVars(includeBundles: {'app'}),
    bundles: [...defaultBundles, AppTemplateBundle()],
  ),
];

final List<AtAppTemplate> samples = [];

final List<AtAppTemplate> demos = [
  ...snackbarApps,
];
