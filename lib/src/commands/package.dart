import 'package:args/command_runner.dart';
import 'package_commands/add.dart';
import 'package_commands/list.dart';
import '../models/command_status.dart';

class PackageCommand extends Command<CommandStatus> {
  @override
  final String name = 'package';

  @override
  final String description = 'View and modify @platform packages';

  PackageCommand() {
    addSubcommand(AddCommand());
    addSubcommand(ListCommand());
  }
}
