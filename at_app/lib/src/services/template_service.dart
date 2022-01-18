import 'package:at_app/src/constants/templates.dart' as c;
import 'package:at_app/src/models/at_app_template.dart';

class TemplateService {
  static AtAppTemplate getTemplate(String name) => c.templates.firstWhere((element) => element.name == name);

  static Map<String, String> get templateNames =>
      c.templates.map((e) => MapEntry(e.name, e.description)) as Map<String, String>;

  static AtAppTemplate getSample(String name) => c.samples.firstWhere((element) => element.name == name);

  static Map<String, String> get sampleNames =>
      c.samples.map((e) => MapEntry(e.name, e.description)) as Map<String, String>;

  static AtAppTemplate getDemo(String name) => c.demos.firstWhere((element) => element.name == name);

  static Map<String, String> get demoNames =>
      c.demos.map((e) => MapEntry(e.name, e.description)) as Map<String, String>;
}
