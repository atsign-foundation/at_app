import 'package:at_app_flutter/src/at_env.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDotEnv extends Mock implements DotEnv {}

void main() {
  group('AtEnv Test', () {
    setUpAll(() {
      AtEnv.dotenvInstance = MockDotEnv();
    });

    test('Get rootDomain', () {
      when(AtEnv.dotenvInstance.maybeGet('ROOT_DOMAIN')).thenReturn('Mock Root Domain');
      expect(AtEnv.rootDomain, 'Mock Root Domain');
    });

    test('Get appNamespace', () {
      when(AtEnv.dotenvInstance.maybeGet('NAMESPACE')).thenReturn('Mock Namespace');
      expect(AtEnv.appNamespace, 'Mock Namespace');
    });

    test('Get appApiKey', () {
      when(AtEnv.dotenvInstance.maybeGet('API_KEY')).thenReturn('Mock Api Key');
      expect(AtEnv.appApiKey, 'Mock Api Key');
      expect(AtEnv.rootEnvironment, RootEnvironment.Production);
    });
  });
}
