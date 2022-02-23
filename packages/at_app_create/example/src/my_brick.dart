import 'package:at_template/at_template.dart';

import 'my_brick_bundle.dart';

class MyBrickVars extends AtTemplateVars {}

class MyBrick extends AtTemplateBundle<MyBrickVars> {
  MyBrick() : super(myBrickBundle);
}
