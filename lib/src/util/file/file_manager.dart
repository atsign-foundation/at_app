import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;

abstract class FileManager {
  final String dir;
  File file;

  static File fileFromPath(String filePath) =>
      File(path.relative(filePath, from: Directory.current.path));

  FileManager(Directory projectDir, this.dir, String filename)
      : file = fileFromPath(
            path.normalize('${projectDir.absolute.path}/$dir/$filename'));

  bool get existsSync => file.existsSync();

  Future<bool> create() async {
    if (!existsSync) {
      try {
        file = await file.create(recursive: true);
      } catch (error) {
        log(error.toString());
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
