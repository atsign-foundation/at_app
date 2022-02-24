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

  int count = await template.generate(dir, vars: vars);
  print('count => $count');
  print('done');
}
