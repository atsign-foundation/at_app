import 'dart:io' show Directory, File, FileMode;

import 'package:at_app/src/services/logger.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' show normalize, relative;

abstract class FileManager {
  final String dir;
  File file;
  final Logger _logger = LoggerService().logger;

  static File fileFromPath(String filePath) =>
      File(relative(filePath, from: Directory.current.path));

  FileManager(Directory projectDir, this.dir, String filename)
      : file = fileFromPath(
            normalize('${projectDir.absolute.path}/$dir/$filename'));

  bool get existsSync => file.existsSync();

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

  Future<void> write(List<String> lines) async {
    var sink = file.openWrite(mode: FileMode.writeOnly);
    sink.writeAll(lines, '\n');
    await sink.flush();
    await sink.close();
  }
}