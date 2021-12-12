import 'dart:io' show Directory, File, FileMode;

import '../util/logger.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' show relative, join;

/// This mixin provides basic file operations
/// for template services that are designed to modify a single file
mixin FileManager {
  final Logger _logger = LoggerService().logger;

  abstract final String filePath;

  late File file;

  /// Must be called in the constructor
  void initFile(path) {
    file = File(
      relative(
        join(path, filePath),
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
