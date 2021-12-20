import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';

import 'package:at_onboarding_flutter/at_onboarding_flutter.dart'
    show Onboarding;
import 'package:at_utils/at_logger.dart' show AtSignLogger;
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;
import 'package:at_app_flutter/at_app_flutter.dart' show AtEnv;

//String snack = '';
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
        ..isLocalStoreRequired = true
      // TODO set the rest of your AtClientPreference here
      ;
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

  final AtSignLogger _logger = AtSignLogger(AtEnv.appNamespace);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // * The onboarding screen (first screen)
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Send yourself a Snackbar'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              onPressed: () async {
                var preference = await futurePreference;
                setState(() {
                  atClientPreference = preference;
                });
                Onboarding(
                  context: context,
                  atClientPreference: atClientPreference!,
                  domain: AtEnv.rootDomain,
                  rootEnvironment: AtEnv.rootEnvironment,
                  appAPIKey: AtEnv.appApiKey,
                  onboard: (value, atsign) {
                    _logger.finer('Successfully onboarded $atsign');
                  },
                  onError: (error) {
                    _logger.severe('Onboarding throws $error error');
                  },
                  nextScreen: const HomeScreen(),
                );
              },
              child: const Text('Onboard an @sign'),
            ),
          ),
        ),
      ),
    );
  }
}

//* The next screen after onboarding (second screen)
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Snack lastsnack = Snack(snack: 'none');
  @override
  Widget build(BuildContext context) {
    /// Get the AtClientManager instance
    var atClientManager = AtClientManager.getInstance();
    String? currentAtsign;
    late AtClient atClient;

    atClient = atClientManager.atClient;
    currentAtsign = atClient.getCurrentAtSign();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar sender'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
                'Successfully onboarded and navigated to FirstAppScreen'),

            /// Use the AtClientManager instance to get the current atsign
            Text('Current @sign: $currentAtsign'),
            const Spacer(flex: 1),
            const Text('Send yourself a snackbar'),
            ElevatedButton(
              onPressed: () {
                sendAtsignData.call(context, lastsnack);
              },
              child: const Text('Send a snack'),
            ),
            const Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }
}

void sendAtsignData(context, Snack lastsnack) async {
  /// Get the AtClientManager instance
  var atClientManager = AtClientManager.getInstance();

  Future<AtClientPreference> futurePreference = loadAtClientPreference();

  var preference = await futurePreference;

  var snacks = [
    ' Milky Way',
    ' Dime Bar',
    ' Crunchy Bar',
    ' Mars Bar',
    ' Snickers Bar',
    ' Zagnut Bar',
    'n Almond Joy Bar',
    ' 3 Musketeers Bar',
    ' Clark Bar',
    ' Caramello Bar',
    ' Twix Bar',
    ' KitKat Bar',
  ];
  String? currentAtsign;
  late AtClient atClient;
  atClient = atClientManager.atClient;
  atClientManager.atClient.setPreferences(preference);
  currentAtsign = atClient.getCurrentAtSign();

  var metaData = Metadata()
    ..isPublic = true
    ..isEncrypted = true
    ..namespaceAware = true
    ..ttl = 100000;

  var key = AtKey()
    ..key = 'snackbar'
    ..sharedBy = currentAtsign
    ..sharedWith = null
    ..metadata = metaData;

  // The magic line to send the snack
  Snack snackbar = Snack(snack: snacks[Random().nextInt(snacks.length)]);
  // Make sure we send a fresh snack !
  while (lastsnack.snack == snackbar.snack) {
    snackbar = Snack(snack: snacks[Random().nextInt(snacks.length)]);
  }
  await atClient.put(key, snackbar.toJson().toString());
  popSnackBar(context, snackbar.snack);
}

void popSnackBar(context, String snack) {
  final snackBar = SnackBar(
    content: Text('We just sent. A$snack ! '),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class Snack {
  String snack;

  Snack({
    required this.snack,
  });

  Snack.fromJson(Map<String, dynamic> json) : snack = json['snack'];

  Map<String, dynamic> toJson() => {
        '"snack"': '"$snack"',
      };
}
