import 'dart:io';

import 'package:mason/mason.dart';

class AtTemplateTarget extends DirectoryGeneratorTarget {
  AtTemplateTarget(Directory dir, [FileConflictResolution? fileConflictResolution])
      : super(dir, null, fileConflictResolution);
}
