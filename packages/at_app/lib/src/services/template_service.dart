import 'package:at_app/src/templates.dart' as c;
import 'package:at_app/src/models/at_app_template.dart';

class TemplateService {
  static AtAppTemplate getTemplate(String name) => c.templates.firstWhere((element) => element.name == name);

  static Map<String, String> get templateNames =>
      Map.fromEntries(c.templates.map((e) => MapEntry(e.name, e.description)));

  static AtAppTemplate getSample(String name) => c.samples.firstWhere((element) => element.name == name);

  static Map<String, String> get sampleNames => Map.fromEntries(c.samples.map((e) => MapEntry(e.name, e.description)));

  static AtAppTemplate getDemo(String name) => c.demos.firstWhere((element) => element.name == name);

  static Map<String, String> get demoNames => Map.fromEntries(c.demos.map((e) => MapEntry(e.name, e.description)));
}
