part of 'cli.dart';

class DartCli {
  static Future<bool> isInstalled() async {
    try {
      await _DartCli.run([]);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<ProcessResult> pubGet({Directory? directory}) {
    return _FlutterCli.run(
      ['pub', 'get'],
      directory: directory?.absolute.path,
    );
  }

  static Future<ProcessResult> runCommand(List<String> args, {bool throwOnError = true, String? directory}) =>
      _DartCli.run(args, throwOnError: throwOnError, directory: directory);
}

class _DartCli {
  static Future<ProcessResult> run(List<String> args, {bool throwOnError = true, String? directory}) {
    return _Cli.run(
      'dart',
      args,
      throwOnError: throwOnError,
      directory: directory,
    );
  }
}
