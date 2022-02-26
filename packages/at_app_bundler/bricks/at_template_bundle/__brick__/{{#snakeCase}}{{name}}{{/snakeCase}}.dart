// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:at_app_create/at_app_create.dart';
{{#additionalImports}}{{{.}}}
{{/additionalImports}}

import '{{#snakeCase}}{{name}}{{/snakeCase}}_bundle.dart';

class {{#pascalCase}}{{name}}{{/pascalCase}}TemplateBundle extends AtTemplateBundle<AtTemplateVars> {
  {{#pascalCase}}{{name}}{{/pascalCase}}TemplateBundle() : super({{#camelCase}}{{name}}{{/camelCase}}Bundle);
}

final AtTemplateVars _vars = AtTemplateVars(
  includeBundles: {'{{name}}'},
{{#additionalVars}}  {{{.}}}
{{/additionalVars}}
);

final AtAppTemplate {{#camelCase}}{{name}}{{/camelCase}}Template = AtAppTemplate(
  name: '{{name}}',
  description: '{{description}}',
  vars: _vars,
  overrideEnv: {{overrideEnv}},
  env: {{{env}}},
  bundles: [
    BaseTemplateBundle(),
    AndroidTemplateBundle(),
    IosTemplateBundle(),
    {{#pascalCase}}{{name}}{{/pascalCase}}TemplateBundle(),
  ],
);
