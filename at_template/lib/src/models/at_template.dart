import 'at_template_bundle.dart';

abstract class AtTemplate {
  abstract final List<AtTemplateBundle> templates;

  Future<int> generate() => throw UnimplementedError();
}
