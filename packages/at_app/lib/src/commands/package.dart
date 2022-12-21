import 'package:args/command_runner.dart';

import '../models/command_status.dart';
import 'package_commands/add.dart';
import 'package_commands/list.dart';

class PackageCommand extends Command<CommandStatus> {
  @override
  final String name = 'packages';

  @override
  final String description = 'Commands for managing atPlatform packages.';

  PackageCommand() {
    addSubcommand(AddCommand());
    addSubcommand(ListCommand());
  }
}
