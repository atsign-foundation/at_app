import 'package:at_app_flutter/src/at_env.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDotEnv extends Mock implements DotEnv {}

void main() {
  group('AtEnv Fallback Test', () {
    setUpAll(() {
      AtEnv.dotenvInstance = MockDotEnv();
    });

    test("Get rootDomain fallback", () {
      when(AtEnv.dotenvInstance.maybeGet("ROOT_DOMAIN")).thenReturn(null);
      expect(AtEnv.rootDomain, "root.atsign.org");
    });

    test("Get appNamespace", () {
      when(AtEnv.dotenvInstance.maybeGet("NAMESPACE")).thenReturn(null);
      expect(AtEnv.appNamespace, "at_skeleton_app");
    });

    test("Get appApiKey", () {
      when(AtEnv.dotenvInstance.maybeGet("API_KEY")).thenReturn(null);
      expect(AtEnv.appApiKey, null);
      expect(AtEnv.rootEnvironment, RootEnvironment.Staging);
    });
  });
}
