import 'package:args/command_runner.dart';
import 'package:logger/logger.dart';

import '../../cli/flutter_cli.dart';
import '../../models/command_status.dart';
import '../../services/logger.dart' show LoggerService;

class AddCommand extends Command<CommandStatus> {
  @override
  final String name = 'add';

  @override
  final String description = 'Add a pub.dev package to your project';

  final Logger _logger = LoggerService().logger;

  @override
  Future<CommandStatus> run() async {
    CommandStatus result = CommandStatus.success;

    if (argResults!.rest.isEmpty) {
      String message = 'No packages specified.';
      throw FormatException(message);
    }

    for (String package in argResults!.rest) {
      try {
        FlutterCli.pubAdd(package);
      } catch (_) {
        result = CommandStatus.warning;
        _logger.w('package "$package" wasn\'t able to be added.');
      }
    }

    return result;
  }
}
