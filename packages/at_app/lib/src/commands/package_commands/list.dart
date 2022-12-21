import 'dart:io' show Platform;

import 'package:args/command_runner.dart';
import 'package:logger/logger.dart';
import 'package:tabular/tabular.dart';

import '../../constants/at_platform_packages.dart';
import '../../models/command_status.dart';
import '../../util/logger.dart';

class ListCommand extends Command<CommandStatus> {
  @override
  final String name = 'list';

  @override
  final String description = '''List available packages on the atPlatform.
The packages are grouped into three categories: flutter, utility, core.''';

  final Logger _logger = LoggerService().logger;

  ListCommand() {
    argParser.addFlag('flutter', abbr: 'f', negatable: false);
    argParser.addFlag('util', abbr: 'u', negatable: false);
    argParser.addFlag('core', abbr: 'c', negatable: false);
    argParser.addFlag('all', abbr: 'a', negatable: false);
  }

  @override
  Future<CommandStatus> run() async {
    int flagCount = 0;
    const List<String> flags = ['flutter', 'util', 'core'];
    final bool showAll = argResults!['all'] ?? false;
    if (showAll) {
      flagCount = flags.length;
    } else {
      /// Count the number of flags to see if we need headers
      for (String flag in flags) {
        if (argResults?[flag] ?? false) {
          flagCount++;
        }
      }
    }

    final bool justFlutter = flagCount == 0;

    List<List<String>> display = [
      ['PACKAGE', 'DESCRIPTION']
    ];
    List<int> rowDividers = [1];

    /// Flutter Packages
    if (showAll || justFlutter || (argResults?['flutter'] ?? false)) {
      if (display.length > 1) rowDividers.add(display.length);
      display.addAll([
        if (flagCount > 1) ['FLUTTER PACKAGES'],
        ...flutterPackages,
      ]);
    }

    /// Utility Packages
    if (showAll || (argResults?['util'] ?? false)) {
      if (display.length > 1) rowDividers.add(display.length);
      display.addAll([
        if (flagCount > 1) ['UTILITY PACKAGES', ''],
        ...utilPackages,
      ]);
    }

    /// Core Packages
    if (showAll || (argResults?['core'] ?? false)) {
      if (display.length > 1) rowDividers.add(display.length);
      display.addAll([
        if (flagCount > 1) ['CORE PACKAGES', ''],
        ...corePackages,
      ]);
    }

    _logger.i('');
    _logger.i(tabular(
      display,
      border: Border.none,
      rowDividers: rowDividers,
    ));

    final String packageCount = '''\nShowing $flagCount/${flags.length} package groups.

To show available groups:
at_app${Platform.isWindows ? '.bat' : ''} packages list --help''';

    final String helpMessage = '''\nTo add a package:
at_app${Platform.isWindows ? '.bat' : ''} packages add <package>''';

    _logger.i(packageCount);
    _logger.i(helpMessage);

    return CommandStatus.success;
  }
}
