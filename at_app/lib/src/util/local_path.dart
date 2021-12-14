import 'dart:io';

import 'package:path/path.dart';

String getLocalPath(filePath, {String? from}) {
  return normalize(
    join(
      Platform.script.path,
      '..', // Step out of src
      '..', // Step out of lib
      '..', // Step out of at_app
      filePath,
    ),
  ).replaceFirst(r'\', '');
}
