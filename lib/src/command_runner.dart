import 'package:args/args.dart' show ArgResults;
import 'package:args/command_runner.dart' show CommandRunner, UsageException;
import 'package:logger/logger.dart' show Logger, ProductionFilter;

import '../version.dart';
import 'commands/command_status.dart';
import 'commands/create.dart';
import 'util/printer.dart';

class AtCommandRunner extends CommandRunner<CommandStatus> {
  final Logger _logger;

  AtCommandRunner({Logger? logger})
      : _logger =
            logger ?? Logger(filter: ProductionFilter(), printer: Printer()),
        super('at_app', 'The @ protocol app developer cli toolkit.') {
    argParser.addFlag(
      'version',
      negatable: false,
      help: 'Print the current version.',
    );
    addCommand(CreateCommand(logger: _logger));
  }

  @override
  Future<CommandStatus> run(Iterable<String> args) async {
    try {
      final _argResults = parse(args);
      return await runCommand(_argResults) ?? CommandStatus.success;
    } on FormatException catch (e, stackTrace) {
      _logger.e(e.message, e, stackTrace);
      _logger.i(usage);
      return CommandStatus.warning;
    } on UsageException catch (e) {
      _logger.e(e.message);
      _logger.i(e.usage);
      return CommandStatus.warning;
    }
  }

  @override
  Future<CommandStatus?> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults['version']) {
      _logger.i('at_app ${packageVersion.toString()}');
      return CommandStatus.success;
    }
    return super.runCommand(topLevelResults);
  }
}
