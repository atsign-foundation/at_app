import 'dart:io';


/// A base class that defines a template service
/// A template service can be responsible for:
/// - generating part of the template
/// - configuring the app
/// - calling other template services with additional configuration
abstract class TemplateServiceBase {
  /// [projectDir] is the directory that the template is being generated in
  final Directory projectDir;

  TemplateServiceBase(this.projectDir);

  /// R
  Future<void> run();
}

