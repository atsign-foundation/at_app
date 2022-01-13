import 'package:mason/mason.dart';

import 'at_vars.dart';

abstract class AtTemplateBundle<V extends AtVars> extends MasonBundle {
  Type get varsType => V;

  AtTemplateBundle(MasonBundle m) : super(m.name, m.description, m.vars, m.files, m.hooks);

  Future<int> generate() => throw UnimplementedError();
}
