import 'dart:io';

import 'package:at_app/src/models/template_service_base.dart';
import 'package:io/io.dart' show copyPath;
import 'package:path/path.dart' show absolute, canonicalize, isWithin, join, relative;

import '../../models/exceptions/template_exception.dart';

class TemplateBuilder extends TemplateServiceBase {
  final String templatePath;
  final bool overwrite;
  TemplateBuilder({
    required Directory projectDir,
    required this.templatePath,
    required this.overwrite,
  }) : super(projectDir);

  @override
  Future<void> run() async {
    String from = absolute(join(templatePath, 'lib'));
    String to = absolute(join(projectDir.absolute.path, 'lib'));

    try {
      await copyTemplate(from, to);
    } catch (_) {
      throw TemplateException('Unable to clone the app template to $projectDir');
    }
  }

  // Copyright 2017, the Dart project authors.  Please see the AUTHORS file
  // for details. All rights reserved. Use of this source code is governed by a
  // BSD-style license that can be found in the LICENSE file.

  // This function is a modification of copyPath in dart:io.
  Future<void> copyTemplate(String from, String to) async {
    if (canonicalize(from) == canonicalize(to) || isWithin(from, to)) throw Exception();
    await Directory(to).create(recursive: true);
    await for (final file in Directory(from).list(recursive: true)) {
      final copyTo = join(to, relative(file.path, from: from));
      if (file is Directory) {
        await Directory(copyTo).create(recursive: true);
      } else if (file is File) {
        if (!overwrite && await File(copyTo).exists()) continue;
        await File(file.path).copy(copyTo);
      } else if (file is Link) {
        if (!overwrite && await Link(copyTo).exists()) continue;
        await Link(copyTo).create(await file.target(), recursive: true);
      }
    }
  }
}
