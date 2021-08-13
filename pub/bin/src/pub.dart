// @dart = 2.8

import 'dart:io';
import 'package:flutter_tools/src/dart/pub.dart';
import 'package:flutter_tools/src/globals.dart' as globals;

Future<bool> add(String package,
    {bool local = false, Directory directory}) async {
  var dir = directory.absolute.path;
  var args = (package == 'at_app' && local)
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
      filter: (String data) => null,
      retry: false,
    );
  } catch (error) {} // pub.batch has it's own handler
  return true;
}

Future<void> get({Directory directory}) async {
  await pub.batch(
    ['get'],
    directory: directory.absolute.path,
    context: PubContext.pubGet,
    filter: (String data) => null,
    retry: false,
  );
}

String _getLocalPath({Directory directory}) {
  // This returns the local relative path of at_app from the projectDir
  return globals.fs.path.relative('${Platform.script.toFilePath()}/../..',
      from: directory.absolute.path);
}
