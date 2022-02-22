import 'dart:io';

import 'package:mason/mason.dart';

import '../util/cli.dart';
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

  Future<List<GeneratedFile>> generate(Directory dir, {required AtTemplateVars vars, bool pub = true, bool overwrite = false}) async {
    List<Future<List<GeneratedFile>>> generatedFiles = [];

    for (String key in vars.bundles) {
      AtTemplateBundle bundle = this[key];

      generatedFiles.add(bundle.generate(DirectoryGeneratorTarget(dir), vars, overwrite: overwrite));
    }

    List<GeneratedFile> fileCount = (await Future.wait(generatedFiles)).reduce((p, c) => [...p, ...c]);

    if (pub && await FlutterCli.isInstalled()) {
      await FlutterCli.pubGet(directory: dir);
    }

    return fileCount;
  }
}
