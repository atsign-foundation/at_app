// @dart = 2.8

import 'dart:io';
import 'package:flutter_tools/src/dart/pub.dart';
import 'package:path/path.dart' as path;

Future<bool> add(String package,
    {bool isDev = false, Directory directory}) async {
  var dir = directory.absolute.path;
  var args = (package == 'at_app' && isDev)
      ? [
          'add',
          '--path',
          _getLocalPath(directory: directory),
          package,
        ]
      : ['add', package];
  try {
    await pub.batch(
      args,
      directory: dir,
      context: PubContext.getVerifyContext('at_app_init'),
      retry: false,
    );
  } catch (error) {} // pub.batch has it's own handler
  return true;
}

Future<void> get(String package, {Directory directory}) async {
  await pub.batch(
    ['pub', 'get'],
    directory: directory.absolute.path,
    context: PubContext.pubGet,
    retry: false,
  );
}

String _getLocalPath({Directory directory}) {
  // This returns the local relative path of at_app from the projectDir
  return path
      .relative('${Platform.script.toFilePath()}/../..',
          from: directory.absolute.path)
      .replaceAll('\\', '/');
}
