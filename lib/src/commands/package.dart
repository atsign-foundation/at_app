import 'package:args/command_runner.dart';
import 'package_commands/add.dart';
import 'package_commands/list.dart';
import '../models/command_status.dart';

class PackageCommand extends Command<CommandStatus> {
  @override
  final String name = 'packages';

  @override
  final String description = 'Commands for managing @platform packages.';

  PackageCommand() {
    addSubcommand(AddCommand());
    addSubcommand(ListCommand());
  }
}
