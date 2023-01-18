import 'package:args/command_runner.dart';
import 'commands/commands.dart';

const exectuableName = 'at_template';
const executableDescription = 'Generate at_templates from the commandline';

class AtTemplateCommandRunner extends CommandRunner<int> {
  AtTemplateCommandRunner() : super(exectuableName, executableDescription) {
    addCommand(AtBundleCommand());
  }

  @override
  Future<int> run(Iterable<String> args) async {
    final argResults = parse(args);
    return await runCommand(argResults) ?? 0;
  }
}
