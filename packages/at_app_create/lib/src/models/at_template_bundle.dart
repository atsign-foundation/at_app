import 'package:mason/mason.dart';

import 'at_vars.dart';

abstract class AtTemplateBundle<V extends AtVars> extends MasonBundle {
  Type get varsType => V;

  AtTemplateBundle(MasonBundle m)
      : super(
          name: m.name,
          version: m.version,
          description: m.description,
          vars: m.vars,
          files: m.files,
          hooks: m.hooks,
        );

  Future<List<GeneratedFile>> generate(DirectoryGeneratorTarget target, V vars, {bool overwrite = false}) async {
    MasonGenerator generator = await MasonGenerator.fromBundle(this);

    Map<String, dynamic> json = vars.toJson();

    // Use default values for missing or null json values.
    for (String key in this.vars.keys) {
      json[key] ??= this.vars[key]!.defaultValue;
      if (json[key] == null) {}
    }

    return generator.generate(
      target,
      vars: json,
      fileConflictResolution: overwrite ? FileConflictResolution.overwrite : FileConflictResolution.skip,
    );
  }
}
