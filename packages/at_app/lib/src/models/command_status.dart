/// An enum for the status of the command
/// The command can be a success, provide a warning, or completely fail.
enum CommandStatus { success, fail }

extension Value on CommandStatus {
  int get code {
    switch (this) {
      case CommandStatus.success:
        return 0;
      case CommandStatus.fail:
        return 1;
    }
  }
}
