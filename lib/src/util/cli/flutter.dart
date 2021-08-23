import 'dart:io';

import 'cli_base.dart';

class Flutter {
  static Future<void> pubAdd(String package, {Directory? directory}) async {
    await _FlutterCli.run(['pub', 'add', package],
        directory: directory?.absolute.path);
  }

  static Future<void> pubGet({Directory? directory}) async {
    await _FlutterCli.run(['pub', 'get'], directory: directory?.absolute.path);
  }

  static Future<void> create(
    Directory directory, {
    bool? pub,
    bool? offline,
    bool? overwrite,
    String? description,
    String? org,
    String? projectName,
    String? iosLanguage,
    String? androidLanguage,
  }) async {
    List<String> args = ['create'];

    if (pub != null) args.add(createBoolFlag('pub', pub));
    if (offline != null) args.add(createBoolFlag('offline', offline));
    if (overwrite != null) args.add(createBoolFlag('overwrite', overwrite));
    if (description != null) args.add('--description=$description');
    if (org != null) args.add('--org=$org');
    if (projectName != null) args.add('--project-name=$projectName');
    if (iosLanguage != null) args.add('--ios-language=$iosLanguage');
    if (androidLanguage != null)
      args.add('--android-language=$androidLanguage');

    args.addAll(['--platforms=android,ios', directory.absolute.path]);

    await _FlutterCli.run(args);
  }

  static String createBoolFlag(String name, bool value) {
    return '--' + (value ? '' : 'no-') + name;
  }
}

class _FlutterCli extends Cli {
  static Future<ProcessResult> run(List<String> args,
      {bool throwOnError = true, String? directory}) {
    return Cli.run(
      'flutter',
      args,
      throwOnError: throwOnError,
      directory: directory,
    );
  }
}
