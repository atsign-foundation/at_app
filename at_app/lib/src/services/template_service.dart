import 'package:at_app/src/constants/templates.dart';
import 'package:at_app/src/models/at_app_template.dart';

class TemplateService {
  static AtAppTemplate getTemplate(String name) => templates.firstWhere((element) => element.name == name);

  static AtAppTemplate getSample(String name) => samples.firstWhere((element) => element.name == name);

  static AtAppTemplate getDemo(String name) => demos.firstWhere((element) => element.name == name);
}
