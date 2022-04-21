import 'package:at_app/src/models/command_status.dart';
import 'package:test/test.dart';

void main() {
  group('CommandStatus', () {
    test('success', () {
      expect(CommandStatus.success.code, 0);
    });

    test('fail', () {
      expect(CommandStatus.fail.code, 1);
    });
  });
}
