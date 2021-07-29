// @dart = 2.8

import 'dart:io';
import 'package:flutter_tools/src/dart/pub.dart';
import 'package:flutter_tools/src/globals.dart' as globals;
import 'package:path/path.dart' as path;

final stdio = globals.stdio;

Future<void> pubAdd(String package,
    {bool isLocal = false, String directory}) async {
  var args = (isLocal)
      ? [
          'add',
          '--path',
          path
              .relative(Directory.current.absolute.path, from: directory)
              .replaceAll('\\', '/'),
          package,
        ]
      : ['add', package];
  await pub.batch(
    args,
    directory: directory,
    context: PubContext.getVerifyContext('at_app_init'),
    retry: false,
  );
}

Future<void> pubGet(String package, {String directory}) async {
  await pub.batch(
    ['pub', 'get'],
    directory: directory,
    context: PubContext.pubGet,
    retry: false,
  );
}
