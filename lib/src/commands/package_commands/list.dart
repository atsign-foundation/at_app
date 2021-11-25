import 'package:args/command_runner.dart';
import 'package:at_app/src/services/logger.dart';
import 'package:logger/logger.dart';
import '../../constants/at_platform_packages.dart';
import '../../models/command_status.dart';

class ListCommand extends Command<CommandStatus> {
  @override
  final String name = 'list';

  @override
  final String description = 'List available packages on the @platform';

  final Logger _logger = LoggerService().logger;

  ListCommand() {
    argParser.addFlag('flutter', defaultsTo: true);
    argParser.addFlag('util', abbr: 'u');
    argParser.addFlag('core', abbr: 'c');
  }

  @override
  Future<CommandStatus> run() async {
    int flagCount = 0;
    const List<String> flags = ['flutter', 'util', 'core'];

    /// Count the number of flags to see if we need headers
    for (String flag in flags) {
      if (argResults?[flag] ?? false) {
        flagCount++;
      }
    }

    /// Nothing to print
    if (flagCount == 0) {
      throw const FormatException(
        'At least one group of packages must be specified',
      );
    }

    /// Print flutter packages
    if (argResults?['flutter'] ?? false) {
      if (flagCount > 1) _logger.i('Flutter Packages:');
      flutterPackages
          .forEach((name, description) => _logger.i('$name\t$description'));
      _logger.i('');
    }

    /// Print utility packages
    if (argResults?['util'] ?? false) {
      if (flagCount > 1) _logger.i('Utility Packages');
      utilPackages
          .forEach((name, description) => _logger.i('$name\t$description'));
      _logger.i('');
    }

    /// Print core packages
    if (argResults?['core'] ?? false) {
      if (flagCount > 1) _logger.i('\nCore Packages');
      corePackages
          .forEach((name, description) => _logger.i('$name\t$description'));
      _logger.i('');
    }

    return CommandStatus.success;
  }
}
