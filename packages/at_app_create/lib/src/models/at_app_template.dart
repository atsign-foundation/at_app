import 'package:at_app_create/at_app_create.dart';

class AtAppTemplate extends AtTemplate {
  final String name;
  final String description;

  final AtTemplateVars vars;

  final bool overrideEnv;
  final Map<String, String>? env;

  @override
  final List<AtTemplateBundle> bundles;

  AtAppTemplate({
    required this.name,
    required this.description,
    required this.vars,
    required this.bundles,
    bool? overrideEnv,
    this.env,
  }) : overrideEnv = overrideEnv ?? false;
}
