import 'package:at_app/src/templates.dart' as templates;
import 'package:at_app_create/at_app_create.dart';
import 'package:collection/collection.dart';

class TemplateService {
  static AtAppTemplate? getTemplate(String name) =>
      templates.templates.firstWhereOrNull((element) => element.name == name);

  static Map<String, String> get templateNames =>
      Map.fromEntries(templates.templates.map((e) => MapEntry(e.name, e.description)));

  static AtAppTemplate? getSample(String name) => templates.samples.firstWhereOrNull((element) => element.name == name);

  static Map<String, String> get sampleNames =>
      Map.fromEntries(templates.samples.map((e) => MapEntry(e.name, e.description)));

  static AtAppTemplate? getDemo(String name) => templates.demos.firstWhereOrNull((element) => element.name == name);

  static Map<String, String> get demoNames =>
      Map.fromEntries(templates.demos.map((e) => MapEntry(e.name, e.description)));
}
