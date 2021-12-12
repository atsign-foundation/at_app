import 'dart:io';

import 'file_manager.dart';
import 'template_service_base.dart';

abstract class FileTemplateServiceBase extends TemplateServiceBase with FileManager {
  String? basePathOverride;
  FileTemplateServiceBase(Directory projectDir) : super(projectDir) {
    initFile(projectDir.absolute.path);
  }
}
