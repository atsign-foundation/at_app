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
    AtAppTemplate? Function(String) getter = TemplateService.getTemplate;

    test('templateNames', () {
      Map<String, String> names = TemplateService.templateNames;
      expect(names.length, templates.length);
      expect(names.keys, templates.map((e) => e.name));
    });

    test('getTemplate non-existent', () {
      AtAppTemplate? template = TemplateService.getTemplate('');
      expect(template, null);
    });

    test('getTemplate app', () => runTest('app', getter));
  });

  group('Sample Functions', () {
    AtAppTemplate? Function(String) getter = TemplateService.getSample;

    test('sampleNames', () {
      Map<String, String> names = TemplateService.sampleNames;
      expect(names.length, samples.length);
      expect(names.keys, samples.map((e) => e.name));
    });

    test('getSample non-existent', () {
      AtAppTemplate? template = TemplateService.getSample('');
      expect(template, null);
    });

    test('getSample at_contacts_flutter', () => runTest('at_contacts_flutter', getter));
    test('getSample at_onboarding_flutter', () => runTest('at_onboarding_flutter', getter));
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
