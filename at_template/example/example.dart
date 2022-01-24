import 'package:at_template/at_template.dart';
import 'package:universal_io/io.dart';

import 'src/my_template.dart';
import 'src/my_brick.dart';
import 'package:path/path.dart';

void main() async {
  MyTemplate template = MyTemplate();
  MyBrickVars vars = MyBrickVars();

  vars.projectName = 'my_project';
  vars.includeBundles(['android', 'ios', 'my_brick']);

  Directory dir = Directory(join(Directory.current.absolute.path, 'my_project'));
  AtTemplateTarget target = AtTemplateTarget(dir);

  int count = await template.generate(target, vars: vars);
  print('count => $count');
  print('done');
}
