import 'package:at_app_create/at_app_create.dart';

import 'my_brick.dart';

class MyTemplate extends AtTemplate {
  @override
  final List<AtTemplateBundle> bundles = [
    AndroidTemplateBundle(),
    BaseTemplateBundle(),
    IosTemplateBundle(),
    MyBrick(),
  ];
}
