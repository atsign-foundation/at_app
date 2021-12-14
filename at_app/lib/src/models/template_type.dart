class Template {
  final TemplateType type;
  final String name;

  Template(this.type, this.name);
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
