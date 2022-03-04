import 'dart:io' show Directory, ProcessResult;

import 'cli_base.dart';

class FlutterCli {
  static Future<ProcessResult> pubAdd(String package,
      {Directory? directory, String? localPath, bool dev = false}) async {
    List<String> command = [
      'pub',
      'add',
      if (dev) '-d',
      package,
      if (localPath != null) ...['--path', localPath],
    ];

    return await _FlutterCli.run(
      command,
      directory: directory?.absolute.path,
      throwOnError: false,
    );
  }

  static Future<bool> isInstalled() async {
    try {
      await _FlutterCli.run([]);
      return true;
    } catch (_) {
      return false;
    }
  }
}

class _FlutterCli extends Cli {
  static Future<ProcessResult> run(List<String> args, {bool throwOnError = true, String? directory}) {
    return Cli.run(
      'flutter',
      args,
      throwOnError: throwOnError,
      directory: directory,
    );
  }
}
