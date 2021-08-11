library at_app;

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:flutter/material.dart';
import 'package:dotenv/dotenv.dart' as dot;

class AtEnv {
  /// Load the environment variables from the .env file.
  /// Directly calls load from the dotenv package.
  static load() => dot.load();

  /// Returns the root domain from the environment.
  /// Root domain is used to control what root server you want to use for the app.
  static final rootDomain = _getEnvVar('ROOT_DOMAIN') ?? 'root.atsign.org';

  /// Returns the namespace from the environment.
  /// Namespace is used to filter by an app's namespace from the secondary server.
  static final appNamespace = _getEnvVar('NAMESPACE') ?? 'at_skeleton_app';

  /// Returns the app api key from the environment.
  /// The api key used to generate free @signs by at_onboarding_flutter.
  /// Also used to pay commissions to developers (email )
  static final appApiKey = _getEnvVar('API_KEY') ?? '';

  /// Returns the value of environment variable [key] loaded from the environment.
  /// Can be used for other environment variables beyond what is included by at_app.
  static String? _getEnvVar(String key) {
    var value = dot.env[key];
    if (value?.isEmpty ?? false) return null;
    return value;
  }
}

class AtContext extends InheritedWidget {
  AtContext({
    Key? key,
    required Widget child,
    required this.atClientService,
    required this.atClientPreference,
  }) : super(key: key, child: child);

  /// The AtClientService exposes a developer friendly abstraction of the @protocol.
  final AtClientService atClientService;

  /// The AtClientImpl is the concrete implementation of the AtClient abstract class.
  AtClientImpl? get atClient => atClientService.atClient;

  /// The AtClientPreference is the developer defined configuration of the AtClientImpl.
  final AtClientPreference atClientPreference;

  /// Get the currently active @sign.
  String? get currentAtSign => atClient?.currentAtSign;

  /// Onboard as another @sign where [atsign] is specified as a string.
  void switchAtsign(String atsign) {
    atClientService.onboard(
      atClientPreference: atClientPreference,
      atsign: atsign,
    );
  }

  /// Calling AtContext.of(context) in the widget tree will provide you with
  /// the nearest instance of AtContext containing all of the getters for this class.
  static AtContext of(BuildContext context) {
    var atContext = context.dependOnInheritedWidgetOfExactType<AtContext>();
    assert(atContext != null);
    return atContext!;
  }

  @override
  bool updateShouldNotify(AtContext oldWidget) {
    return true;
  }
}
