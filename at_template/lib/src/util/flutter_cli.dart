part of 'cli.dart';

class FlutterCli {
  static Future<bool> isInstalled() async {
    try {
      await run([]);
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<ProcessResult> pubGet({Directory? directory}) {
    return run(
      ['pub', 'get'],
      directory: directory?.absolute.path,
    );
  }

  static Future<ProcessResult> run(List<String> args, {bool throwOnError = true, String? directory}) =>
      _Cli.run(
      'flutter',
      args,
      throwOnError: throwOnError,
      directory: directory,
    );
}
