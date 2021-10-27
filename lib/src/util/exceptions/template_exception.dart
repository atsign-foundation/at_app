/// An exception thrown when a template file fails to be copied
class TemplateException implements Exception {
  final String message = 'Unable to replace project with the template.';
}
