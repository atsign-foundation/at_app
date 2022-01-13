part of 'cli.dart';

class FlutterCli {
  static Future<bool> isInstalled() async {
    try {
      await _FlutterCli.run([]);
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
}

class _FlutterCli {
  static Future<ProcessResult> run(List<String> args, {bool throwOnError = true, String? directory}) {
    return _Cli.run(
      'flutter',
      args,
      throwOnError: throwOnError,
      directory: directory,
    );
  }
}
