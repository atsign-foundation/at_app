import 'dart:io';

import 'package:at_app/src/services/env_manager.dart';
import 'package:test/test.dart';

void main() {
  group('EnvManager', () {
    EnvManager envManager = EnvManager(Directory.current, environment: {'Key': 'Value', 'Test': 'ABCDE'});
    List<String> lines = [];

    setUpAll(() async {
      await envManager.create();
      await envManager.write(['Key=WrongValue']);
      lines = await envManager.readAsLines();
    });

    tearDownAll(() async {
      await envManager.file.delete();
    });

    test('updateLines', () async {
      expect(lines, ['Key=WrongValue']);
      lines = envManager.updateLines(lines);
      expect(lines, ['Key=Value']);
    });

    test('addLines', () async {
      lines = envManager.addLines(lines);
      expect(lines, ['Key=Value', 'Test=ABCDE']);
    });
  });
}
