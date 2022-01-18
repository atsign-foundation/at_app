import 'package:at_template/at_template.dart';

class AtAppTemplate extends AtTemplate {
  final String name;
  final String description;

  @override
  final List<AtTemplateBundle> bundles;

  AtAppTemplate(this.name, this.description, this.bundles);
}

enum TemplateType {
  template,
  sample,
  demo,
}

extension TemplateTypeString on TemplateType {
  String get path {
    switch (this) {
      case TemplateType.sample:
        return 'samples';
      case TemplateType.demo:
        return 'demos';
      case TemplateType.template:
      default:
        return 'templates';
    }
  }
}
