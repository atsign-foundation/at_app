import 'package:at_app/src/models/file_manager.dart';
import 'package:test/test.dart';

class EmptyFileManager with FileManager {
  @override
  final String filePath = 'test_file.txt';
}

void main() {
  group('FileManager', () {
    FileManager fileManager = EmptyFileManager();

    setUpAll(() {
      fileManager.initFile('.');
      if (fileManager.file.existsSync()) {
        fileManager.file.deleteSync();
      }
    });

    tearDownAll(() {
      fileManager.file.deleteSync();
    });

    test('initFile', () {
      expect(fileManager.file.path, fileManager.filePath);
    });

    test('existsSync', () {
      expect(fileManager.existsSync, false);
    });

    test('create', () async {
      expect(await fileManager.create(), true);
      expect(fileManager.existsSync, true);
    });

    test('write + read', () async {
      await fileManager.write(['Line 1', 'Line 2']);
      List<String> contents = await fileManager.readAsLines();
      expect(contents, ['Line 1', 'Line 2']);
    });
  });
}
