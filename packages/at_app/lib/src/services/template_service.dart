import 'package:at_app/src/templates.dart' as templates;
import 'package:at_app_create/at_app_create.dart';
import 'package:collection/collection.dart';

class TemplateService {
  static AtAppTemplate getTemplate() => templates.mainTemplate;

  static AtAppTemplate? getDemo(String name) => templates.demos.firstWhereOrNull((element) => element.name == name);

  static Map<String, String> get demoNames =>
      Map.fromEntries(templates.demos.map((e) => MapEntry(e.name, e.description)));
}
