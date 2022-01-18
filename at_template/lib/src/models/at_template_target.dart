import 'package:universal_io/io.dart';
import 'package:mason/mason.dart';

class AtTemplateTarget extends DirectoryGeneratorTarget {
  AtTemplateTarget(Directory dir, [bool overwrite = false])
      : super(dir, null, overwrite ? FileConflictResolution.overwrite : FileConflictResolution.skip);
}
