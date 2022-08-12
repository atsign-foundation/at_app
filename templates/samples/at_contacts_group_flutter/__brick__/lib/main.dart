import 'dart:async';

import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';

import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_utils/at_logger.dart' show AtSignLogger;
import 'package:path_provider/path_provider.dart' show getApplicationSupportDirectory;
import 'package:at_app_flutter/at_app_flutter.dart' show AtEnv;
import 'package:flutter_keychain/flutter_keychain.dart';

import 'home_screen.dart';

Future<void> main() async {
  await AtEnv.load();
  runApp(const MyApp());
}

Future<AtClientPreference> loadAtClientPreference() async {
  var dir = await getApplicationSupportDirectory();
  return AtClientPreference()
    ..rootDomain = AtEnv.rootDomain
    ..namespace = AtEnv.appNamespace
    ..hiveStoragePath = dir.path
    ..commitLogPath = dir.path
    ..isLocalStoreRequired = true;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // * load the AtClientPreference in the background
  Future<AtClientPreference> futurePreference = loadAtClientPreference();
  AtClientPreference? atClientPreference;
  AtClientService? atClientService;

  final AtSignLogger _logger = AtSignLogger(AtEnv.appNamespace);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // * The onboarding screen (first screen)
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Builder(
            builder: (context) => Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Center(
                      child: Text(
                          'A client service should create an atClient instance and call onboard method before navigating to QR scanner screen',
                          textAlign: TextAlign.center),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      AtOnboardingResult onboardingResult = await AtOnboarding.onboard(
                        context: context,
                        config: AtOnboardingConfig(
                          atClientPreference: await futurePreference,
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
                const SizedBox(
                  height: 25,
                ),
                Center(
                    child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
                        ),
                        onPressed: () {
                          FlutterKeychain.remove(key: '@atsign');
                        },
                        child: const Text('Clear paired atsigns',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            )))),
              ],
            ),
          )),
    );
  }
}
