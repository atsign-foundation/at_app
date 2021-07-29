// @dart = 2.8

import 'dart:io';
import 'package:flutter_tools/src/dart/pub.dart';
import 'package:path/path.dart' as path;

Future<void> add(String package,
    {bool isLocal = false, Directory directory}) async {
  var dir = directory.absolute.path;
  var args = (isLocal)
      ? [
          'add',
          '--path',
          path
              .relative(Directory.current.absolute.path, from: dir)
              .replaceAll('\\', '/'),
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
  } catch (e) {}
}

Future<void> get(String package, {Directory directory}) async {
  await pub.batch(
    ['pub', 'get'],
    directory: directory.absolute.path,
    context: PubContext.pubGet,
    retry: false,
  );
}
