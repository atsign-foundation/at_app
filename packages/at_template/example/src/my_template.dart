import 'package:at_template/at_template.dart';

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
