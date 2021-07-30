// Copyright 2014 The Flutter Authors. All rights reserved.

// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:

//     * Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
//       copyright notice, this list of conditions and the following
//       disclaimer in the documentation and/or other materials provided
//       with the distribution.
//     * Neither the name of Google Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.

// * Parts of this file are from the flutter sdk package: flutter_tools/src/commands/create_base.dart
// * modification: Customized to build our skeleton app template on top of flutter create

// @dart = 2.8
import 'dart:io';

import '../file/template_manager.dart';
import '../file/android/app_build_gradle_manager.dart';
import '../file/android/gradle_properties_manager.dart';
import '../file/env_manager.dart';
import '../pub.dart' as pub;

import 'package:flutter_tools/src/features.dart';
import 'package:flutter_tools/src/commands/create_base.dart';
import 'package:flutter_tools/src/runner/flutter_command.dart';
import 'package:flutter_tools/src/base/common.dart';
import 'package:flutter_tools/src/globals.dart' as globals;

enum AtAppProjectType {
  application,
}

const String kPlatformHelp = 'The platforms supported by this project. '
    'Platform folders (e.g. android/) will be generated in the target project. '
    'This argument only works when "--template" is set to app or plugin. '
    'When adding platforms to a plugin project, the pubspec.yaml will be updated with the requested platform. '
    'Adding desktop platforms requires the corresponding desktop config setting to be enabled.';

class AtCreateCommand extends CreateBase {
  AtCreateCommand({
    bool verboseHelp = false,
  }) : super(verboseHelp: verboseHelp) {
    addPlatformsOptions(customHelp: kPlatformHelp);
    argParser.addOption(
      'namespace',
      abbr: 'n',
      help: 'The @protocol app namespace to use for the application.',
      defaultsTo: '',
      valueHelp: 'namespace',
    );
    argParser.addOption(
      'root-domain',
      abbr: 'r',
      help: 'The @protocol root domain to use for the application.',
      allowed: ['prod', 'dev', 've'],
      defaultsTo: 'prod',
      valueHelp: 'prod | dev | ve',
    );
    argParser.addOption(
      'api-key',
      abbr: 'k',
      help: 'The api key for at_onboarding_flutter.',
      defaultsTo: '',
      valueHelp: 'api-key',
    );
    argParser.addFlag(
      'local',
      help:
          'Use the local version of at_app as a dependency instead of from pub.dev',
      defaultsTo: false,
      hide: true,
    );
    // TODO add our templates/samples
  }

  @override
  final String name = 'create';

  @override
  final String description = 'Create a new @app project';

  @override
  String get invocation => '${runner.executableName} $name <output directory>';

  int generatedFileCount;

  @override
  Future<FlutterCommandResult> runCommand() async {
    validateOutputDirectoryArg();

    // Create a TemplateManager for the main file
    final TemplateManager mainFileManager = TemplateManager(
      projectDir,
      'lib/main.dart',
      '${Platform.script.toFilePath()}/../../lib/templates/main.dart',
    );

    // Store whether the mainFile exists or not
    final bool mainExists = mainFileManager.existsSync;

    final List<String> platforms = stringsArg('platforms');
    if (platforms == null || platforms.isEmpty) {
      throwToolExit('Must specify at least one platform using --platforms',
          exitCode: 2);
    }

    // for now we only support apps
    AtAppProjectType template = AtAppProjectType.application;

    final String organization = await getOrganization();

    final bool overwrite = boolArg('overwrite');

    final Map<String, dynamic> templateContext = createTemplateContext(
        organization: organization,
        projectName: projectName,
        projectDescription: stringArg('description'),
        flutterRoot: flutterRoot,
        androidLanguage: stringArg('android-language'),
        iosLanguage: stringArg('ios-language'),
        ios: featureFlags.isIOSEnabled && platforms.contains('ios'),
        android: featureFlags.isAndroidEnabled && platforms.contains('android'),
        web: featureFlags.isWebEnabled && platforms.contains('web'),
        linux: featureFlags.isLinuxEnabled && platforms.contains('linux'),
        macos: featureFlags.isMacOSEnabled && platforms.contains('macos'),
        windows: featureFlags.isWindowsEnabled && platforms.contains('windows'),
        windowsUwp:
            featureFlags.isWindowsUwpEnabled && platforms.contains('winuwp'),
        // Enable null safety everywhere.
        dartSdkVersionBounds: '">=2.12.0 <3.0.0"');

    String projectType;
    generatedFileCount = 0;

    final String relativeDirPath = globals.fs.path.relative(projectDirPath);
    final Directory relativeDir = globals.fs.directory(projectDirPath);
    final String relativeAppMain =
        globals.fs.path.join(relativeDirPath, 'lib', 'main.dart');

    final bool creatingNewProject =
        !projectDir.existsSync() || projectDir.listSync().isEmpty;

    if (creatingNewProject) {
      globals.printStatus('Creating project $relativeDirPath...');
    } else {
      globals.printStatus('Recreating project $relativeDirPath...');
    }

    switch (template) {
      case AtAppProjectType.application:
        projectType = 'application';
        generatedFileCount += await generateApp(relativeDir, templateContext,
            overwrite: overwrite);
        break;
    }

    globals.printStatus('\nYour flutter template has been initialized.');
    globals.printStatus('Now creating the @platform template.');

    var results = await Future.wait([
      _updateEnvFile(),
      _addDependencies(),
      if (!mainExists || overwrite) mainFileManager.copyTemplate(),
      _androidConfig(),
    ]);

    results.forEach((result) {
      if (!result) {
        throwToolExit(
          'There was an issue generating your @platform $projectType',
          exitCode: 3,
        );
      }
    });

    globals.printStatus('\nWrote $generatedFileCount total files.');
    globals.printStatus('\nAll done!');

    globals.printStatus('''
In order to run your @platform $projectType, type:

\$ cd $relativeDirPath
\$ flutter run

Your $projectType code is in $relativeAppMain.
''');

    return FlutterCommandResult.success();
  }

  // * .env file

  Future<bool> _updateEnvFile() async {
    var values = _parseEnvArgs();
    generatedFileCount++;
    return EnvManager(projectDir).update(values);
  }

  Map<String, String> _parseEnvArgs() {
    Map<String, String> result = {};
    if (argResults.wasParsed('namespace')) {
      result['NAMESPACE'] = stringArg('namespace');
    }
    if (argResults.wasParsed('root-domain')) {
      result['ROOT_DOMAIN'] = _getRootDomain(stringArg('root-domain'));
    }
    if (argResults.wasParsed('api-key')) {
      result['API_KEY'] = stringArg('api-key');
    }
    return result;
  }

  String _getRootDomain(String flag) {
    switch (flag) {
      case 'dev':
        return 'root.atsign.wtf';
      case 've':
        return 'vip.ve.atsign.zone';
      case 'prod':
      default:
        return 'root.atsign.org';
    }
  }

  // * dependencies for skeleton_app

  Future<bool> _addDependencies() async {
    final List<String> packages = [
      'at_client_mobile',
      'at_onboarding_flutter',
      'at_app'
    ];
    final bool local = boolArg('local');
    List<Future> futures = packages.map((package) async {
      return await pub.add(package, local: local, directory: projectDir);
    }).toList();
    if (boolArg('pub')) {
      await pub.get(directory: projectDir);
    }
    return (await Future.wait(futures)).every((res) => res);
  }

  // * update the flutter android config

  Future<bool> _androidConfig() async {
    List<Future> futures = [
      GradlePropertiesManager(projectDir).update(),
      AppBuildGradleManager(projectDir).update()
    ];
    return (await Future.wait(futures)).every((res) => res);
  }
}
