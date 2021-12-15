import 'dart:io';

import 'package:at_app/src/models/template_service_base.dart';
import 'package:io/io.dart' show copyPath;
import 'package:path/path.dart' show absolute, join;

import '../../models/exceptions/template_exception.dart';

class TemplateBuilder extends TemplateServiceBase {
  final String templatePath;

  TemplateBuilder({
    required Directory projectDir,
    required this.templatePath,
  }) : super(projectDir);

  @override
  Future<void> run() async {
    String from = absolute(join(templatePath, 'lib'));
    String to = absolute(join(projectDir.absolute.path, 'lib'));

    try {
      await copyPath(from, to);
    } catch (_) {
      throw TemplateException('Unable to clone the app template to $projectDir');
    }
  }
}
