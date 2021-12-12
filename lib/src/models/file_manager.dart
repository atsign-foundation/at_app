import 'dart:io' show Directory, File, FileMode;

import 'template_service_base.dart';
import '../util/logger.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' show relative, join;

/// A mixin on [TemplateServiceBase]
/// This mixin provides basic file operations
/// for template services that are designed to modify a single file
mixin FileManager on TemplateServiceBase {
  final Logger _logger = LoggerService().logger;

  abstract final String filePath;

  late File file;

  /// Called in the constructor of the template service
  /// By default the base path for the file is [projectDir]
  /// but can be overridden with [overridePath]
  void initFile({String? overridePath}) {
    String basePath = overridePath ?? super.projectDir.absolute.path;
    file = File(
      relative(
        join(basePath, filePath),
        from: Directory.current.path,
      ),
    );
  }

  /// Calls [file.existsSync()]
  bool get existsSync => file.existsSync();

  /// Recursively create [file] if it doesn't already exist
  Future<bool> create() async {
    if (!existsSync) {
      try {
        file = await file.create(recursive: true);
      } catch (error) {
        _logger.e(error.toString());
        return false;
      }
    }
    return true;
  }

  /// Write [lines] to [file]
  Future<void> write(List<String> lines) async {
    var sink = file.openWrite(mode: FileMode.writeOnly);
    sink.writeAll(lines, '\n');
    await sink.flush();
    await sink.close();
  }
}
