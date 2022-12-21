import 'package:args/command_runner.dart';
import 'package:at_app/src/services/env_manager.dart';
import 'package:at_app/src/services/template_service.dart';
import 'package:at_app/src/util/root_domain.dart';
import 'package:at_app_create/at_app_create.dart';
import 'package:mason/mason.dart' hide Logger;
import 'package:tabular/tabular.dart';

import '../util/logger.dart';

import '../util/namespace.dart';
import 'package:logger/logger.dart' show Logger;
import 'package:path/path.dart' show join, relative;

import '../models/command_status.dart';
import 'package:at_app_create/commands.dart';

const defaultTemplateName = 'app';

const platforms = ['android', 'ios'];

/// This class extends the flutter create abstraction,
/// It will pull templates from at_app_flutter
/// and uses the respective template generator to generate the full template.
class CreateCommand extends AtCreateCommand<CommandStatus> {
  @override
  final String description = 'Create a new atPlatform Flutter project.';
  final Logger _logger = LoggerService().logger;
  CreateCommand({Logger? logger})
      : super(
          successValue: CommandStatus.success,
          availablePlatforms: platforms,
          allCreatePlatforms: platforms,
        ) {
    /// at_app specific options and flags
    argParser.addOption(
      'namespace',
      abbr: 'n',
      help: 'The @protocol app namespace to use for the application. (Use an @sign you own)',
      defaultsTo: '',
      valueHelp: '@youratsign',
    );
    argParser.addOption(
      'root-domain',
      abbr: 'r',
      help: 'The @protocol root domain to use for the application.',
      allowed: ['prod', 've'],
      defaultsTo: 'prod',
      valueHelp: 'prod (production) | ve (virtual environment)',
    );
    argParser.addOption(
      'api-key',
      abbr: 'k',
      help: 'The api key for at_onboarding_flutter.',
      defaultsTo: '',
      valueHelp: 'api-key',
    );
    argParser.addOption(
      'template',
      abbr: 't',
      help: 'The app template to generate.',
      allowed: TemplateService.templateNames.keys,
      defaultsTo: defaultTemplateName,
      valueHelp: 'template-name',
      hide: true,
    );
    argParser.addFlag(
      'list-templates',
      hide: true,
    );
    argParser.addOption(
      'sample',
      abbr: 's',
      help: 'The package sample to generate.',
      allowed: TemplateService.sampleNames.keys,
      valueHelp: 'sample-name',
      hide: true,
    );
    argParser.addFlag(
      'list-samples',
      hide: true,
    );
    argParser.addOption(
      'demo',
      abbr: 'd',
      help: 'The demo app to generate.',
      allowed: TemplateService.demoNames.keys,
      valueHelp: 'demo-app-name',
      hide: true,
    );
    argParser.addFlag(
      'list-demos',
      hide: true,
    );
    argParser.addFlag(
      'local',
      help: 'Use local copy of at_app for development',
      defaultsTo: false,
      hide: true,
    );
  }

  @override
  Future<CommandStatus> run() async {
    if (argResults!.wasParsed('list-templates')) {
      return _listOptions(TemplateService.templateNames, 'TEMPLATE');
    }

    if (argResults!.wasParsed('list-samples')) {
      return _listOptions(TemplateService.sampleNames, 'SAMPLE');
    }

    if (argResults!.wasParsed('list-demos')) {
      return _listOptions(TemplateService.demoNames, 'DEMO');
    }

    /// Input validation checks
    validateOutputDirectoryArg();
    validateEnvironment();

    /// These variables are for print formatting
    final bool creatingNewProject = !projectDir.existsSync() || projectDir.listSync().isEmpty;

    final String relativeOutputPath = relative(projectDir.absolute.path);

    final String relativeAppMain = join(relativeOutputPath, 'lib', 'main.dart');

    // Copyright 2014 The Flutter Authors. All rights reserved.
    if (creatingNewProject) {
      _logger.i('Creating project in $relativeOutputPath');
    } else {
      _logger.i('Recreating project in $relativeOutputPath');
    }

    /// Run the base class' validation checks
    CommandStatus flutterCreateResult = await super.run();
    if (flutterCreateResult != CommandStatus.success) {
      return flutterCreateResult;
    }

    _logger.i('');
    if (creatingNewProject) {
      _logger.i('Project created, now adding a little @ magic...');
    } else {
      _logger.i('Project recreated, now adding a little @ magic...');
    }

    try {
      final bool overwrite = boolArg('overwrite') ?? false;
      final bool pub = boolArg('pub') ?? false;

      /// Generate the template
      AtAppTemplate template = _parseTemplate();
      AtTemplateVars vars = _parseVars(template);

      EnvManager envManager = EnvManager(projectDir, environment: _parseEnvironment(template));

      List<dynamic> futures = await Future.wait(
          [template.generate(projectDir, vars: vars, pub: pub, overwrite: overwrite), envManager.run()]);

      List<GeneratedFile> generatedFiles = futures[0];

      _logger.i('');
      _logger.i('Generated ${generatedFiles.length} files.');
    } catch (e) {
      _logger.e('There was an issue generating your template:\n', e.toString());
      _logger
          .i('Please file a ticket to prevent this from happening again:\nhttps://github.com/atsign-foundation/at_app');

      return CommandStatus.fail;
    }

    _logger.i('');
    _logger.i('All done!');

    // Copyright 2014 The Flutter Authors. All rights reserved.
    _logger.i('''

In order to run your atPlatform application, type:

\$ cd $relativeOutputPath
\$ flutter run

Your application code is in $relativeAppMain.

Happy coding!
''');

    return CommandStatus.success;
  }

  void validateEnvironment() {
    if (argResults!.wasParsed('namespace')) {
      normalizeNamespace(argResults!['namespace'] as String);
    }
  }

  AtAppTemplate _parseTemplate() {
    bool templateParsed = argResults!.wasParsed('template');
    bool sampleParsed = argResults!.wasParsed('sample');
    bool demoParsed = argResults!.wasParsed('demo');

    int parseCount = 0;
    for (bool wasParsed in [templateParsed, sampleParsed, demoParsed]) {
      if (wasParsed) parseCount++;
    }

    if (parseCount > 1) {
      throw UsageException('Only specify one of the following: [template, sample, demo]', '');
    }

    if (templateParsed) {
      return TemplateService.getTemplate(stringArg('template') ?? 'app')!;
    }

    if (sampleParsed) {
      return TemplateService.getSample(stringArg('sample')!)!;
    }

    if (demoParsed) {
      return TemplateService.getDemo(stringArg('demo')!)!;
    }

    return TemplateService.getTemplate(defaultTemplateName)!;
  }

  AtTemplateVars _parseVars(AtAppTemplate template) {
    AtTemplateVars vars = template.vars;
    vars.projectName = packageName;
    if (argResults!.wasParsed('description')) vars.description = stringArg(description)!;
    if (argResults!.wasParsed('org')) {
      List<String> orgParts = stringArg('org')!.split('.');
      vars.orgTld = orgParts[0];
      vars.orgDomainName = orgParts[1];
    }
    if (argResults!.wasParsed('platforms')) {
      vars.includeBundles(argResults!['platforms'] as List<String>);
    } else {
      vars.includeBundles(['android', 'ios']);
    }
    return vars;
  }

  Map<String, String> _parseEnvironment(AtAppTemplate template) {
    if (template.overrideEnv) {
      return template.env!;
    }
    Map<String, String> environment = {};
    if (argResults!.wasParsed('namespace')) {
      environment['NAMESPACE'] = normalizeNamespace(
        argResults!['namespace'] as String,
      );
    }
    if (argResults!.wasParsed('root-domain')) {
      environment['ROOT_DOMAIN'] = getRootDomain(
        argResults!['root-domain'] as String,
      );
    }
    if (argResults!.wasParsed('api-key')) {
      environment['API_KEY'] = argResults!['api-key'] as String;
    }
    return environment;
  }

  CommandStatus _listOptions(Map<String, String> options, String header) {
    List<List<String>> display = [
      [header, 'DESCRIPTION']
    ];

    display.addAll(
      options.entries.map((entry) => [entry.key, entry.value]).toList(),
    );

    _logger.i('');
    _logger.i(tabular(
      display,
      border: Border.none,
    ));

    return CommandStatus.success;
  }
}
