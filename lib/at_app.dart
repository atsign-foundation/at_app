library at_app;

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:flutter/material.dart';
import 'package:dotenv/dotenv.dart' as dot;

class AtEnv {
  static load() => dot.load();
  static final rootDomain = dot.env['ROOT_DOMAIN'] ?? 'root.atsign.org';
  static final appNamespace = dot.env['NAMESPACE'] ?? 'at_skeleton_app';
  static final appApiKey = dot.env['API_KEY'] ?? '';
}

class AtContext extends InheritedWidget {
  AtContext({
    Key? key,
    required Widget child,
    required this.atClientService,
    required this.atClientPreference,
  }) : super(key: key, child: child);

  final AtClientService atClientService;
  final AtClientPreference atClientPreference;
  AtClientImpl? get atClient => atClientService.atClient;
  String? get currentAtSign => atClient?.currentAtSign;

  void switchAtsign(String atsign) {
    atClientService.onboard(
      atClientPreference: atClientPreference,
      atsign: atsign,
    );
  }

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
