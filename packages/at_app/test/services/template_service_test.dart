import 'package:at_app/src/services/template_service.dart';
import 'package:at_app/src/templates.dart';
import 'package:at_app_create/at_app_create.dart';
import 'package:test/test.dart';

void runTest(String name, AtAppTemplate? Function(String) getter) {
  AtAppTemplate? template = getter(name);
  expect(template, isNot(null));
  expect(template!.name, name);
}

void main() {
  group('Template Functions', () {
    test('getTemplate app', () {
      AtAppTemplate template = TemplateService.getTemplate();
      expect(template, mainTemplate);
    });
  });

  group('Demo Functions', () {
    AtAppTemplate? Function(String) getter = TemplateService.getDemo;

    test('demoNames', () {
      Map<String, String> names = TemplateService.demoNames;
      expect(names.length, demos.length);
      expect(names.keys, demos.map((e) => e.name));
    });

    test('getDemo non-existent', () {
      AtAppTemplate? template = TemplateService.getDemo('');
      expect(template, null);
    });

    test('getDemo snackbar', () => runTest('snackbar', getter));
    test('getDemo snackbar_sender', () => runTest('snackbar_sender', getter));
    test('getDemo chit_chat', () => runTest('chit_chat', getter));
  });
}
