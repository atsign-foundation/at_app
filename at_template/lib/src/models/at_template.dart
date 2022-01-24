import '../util/cli.dart';
import '../util/sum.dart';
import '../vars/vars.dart';
import 'models.dart';

abstract class AtTemplate {
  abstract final List<AtTemplateBundle> bundles;

  operator [](String name) {
    return bundles.firstWhere(
      (bundle) => bundle.name == name,
      orElse: () => throw Exception(), // TODO impl better exception
    );
  }

  Future<int> generate(AtTemplateTarget target, {required AtTemplateVars vars, bool pub = true}) async {
    List<Future<int>> fileCounts = [];

    for (String key in vars.bundles) {
      AtTemplateBundle bundle = this[key];

      fileCounts.add(bundle.generate(target, vars));
    }

    int fileCount = (await Future.wait(fileCounts)).reduce(sum);

    if (pub && await FlutterCli.isInstalled()) {
      await FlutterCli.pubGet(directory: target.dir);
    }

    return fileCount;
  }
}
