import 'package:at_app_flutter/at_app_flutter.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import '../services/client.sdk.services.dart';
import 'package:flutter/material.dart';
import 'package:at_utils/at_logger.dart' show AtSignLogger;

import 'home.screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
    required this.clientSdkService,
    required AtSignLogger logger,
  })  : _logger = logger,
        super(key: key);

  final ClientSdkService clientSdkService;
  final AtSignLogger _logger;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyApp'),
      ),
      body: Builder(
        builder: (context) => Center(
          child: ElevatedButton(
              onPressed: () async {
                AtOnboardingResult onboardingResult = await AtOnboarding.onboard(
                  context: context,
                  config: AtOnboardingConfig(
                    atClientPreference: clientSdkService.atClientPreference,
                    rootEnvironment: AtEnv.rootEnvironment,
                    domain: AtEnv.rootDomain,
                    appAPIKey: AtEnv.appApiKey,
                  ),
                );
                switch (onboardingResult.status) {
                  case AtOnboardingResultStatus.success:
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                    break;
                  case AtOnboardingResultStatus.error:
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('An error has occurred'),
                      ),
                    );
                    break;
                  case AtOnboardingResultStatus.cancel:
                    break;
                }
              },
              child: const Text('Onboard an @sign'),
            ),
        ),
      ),
    );
  }
}
