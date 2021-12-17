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
          title: const Text('Snackbar'),
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
  @override
  Widget build(BuildContext context) {
    /// Get the AtClientManager instance
    var atClientManager = AtClientManager.getInstance();
    String? currentAtsign;
    late AtClient atClient;
    final myController = TextEditingController();

    var notificationService = atClientManager.notificationService;
    notificationService.subscribe(regex: AtEnv.appNamespace).listen((notification) {
      getAtsignData(context, notification.key);
    });

    atClient = atClientManager.atClient;
    currentAtsign = atClient.getCurrentAtSign();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
                'Successfully onboarded and navigated to FirstAppScreen'),

            /// Use the AtClientManager instance to get the current atsign
            Text('Current @sign: $currentAtsign'),
            const Spacer(flex: 1),
            const Text('Which @sign would you like to send a snack to ?'),
            TextField(
              controller: myController,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                sendAtsignData(myController.text);
              },
              child: const Text('Send a snack'),
            )
          ],
        ),
      ),
    );
  }
}

void getAtsignData(context, String notificationKey) async {
  /// Get the AtClientManager instance
  var atClientManager = AtClientManager.getInstance();

  Future<AtClientPreference> futurePreference = loadAtClientPreference();

  var preference = await futurePreference;

  String? currentAtsign;
  late AtClient atClient;
  atClient = atClientManager.atClient;
  atClientManager.atClient.setPreferences(preference);
  currentAtsign = atClient.getCurrentAtSign();

  //Split the notification to get the key and the sharedByAtsign
  // Notification looks like this :-
  // @ai6bh:snackbar.colin@colin
  var notificationList = notificationKey.split(':');
  String sharedByAtsign = '@' + notificationList[1].split('@').last;
  String keyAtsign = notificationList[1];
  keyAtsign = keyAtsign.replaceAll('.${preference.namespace.toString()}$sharedByAtsign', '');

  var metaData = Metadata()
    ..isPublic = false
    ..isEncrypted = true
    ..namespaceAware = true;

  var key = AtKey()
    ..key = keyAtsign
    ..sharedBy = sharedByAtsign
    ..sharedWith = currentAtsign
    ..metadata = metaData;

  // The magic line that picks up the snack
  var snackKey = await atClient.get(key);
  // Yes that is all you need to do! 
  var snack = snackKey.value.toString();

  final snackBar = SnackBar(
    content: Text('Yay! A$snack ! From $sharedByAtsign'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void sendAtsignData(String sendSnackTo) async {
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
    ..isPublic = false
    ..isEncrypted = true
    ..namespaceAware = true
    ..ttl = 100000;

  var key = AtKey()
    ..key = 'snackbar'
    ..sharedBy = currentAtsign
    ..sharedWith = sendSnackTo
    ..metadata = metaData;

  // The magic line to send the snack
  await atClient.put(key, snacks[Random().nextInt(snacks.length)]);
}
