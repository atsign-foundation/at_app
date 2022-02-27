import 'package:at_onboarding_flutter/at_onboarding_flutter.dart' show RootEnvironment;
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;

/// AtEnv is a helper class to load in the environment variables from the .env file
class AtEnv {
  /// Load the environment variables from the .env file.
  ///
  /// Calls [load()] from flutter_dotenv package.
  static Future<void> load() => dotenv.load();

  /// Returns the value for ['ROOT_DOMAIN'] from the .env file.
  ///
  /// Fallback value: ['root.atsign.org']
  ///
  /// Root domain is used to control what root server you want to use for the app.
  /// The vast majority of apps will use ['root.atsign.org'].
  static final String rootDomain = getEnv('ROOT_DOMAIN', fallback: 'root.atsign.org');

  /// Returns the value for ['NAMESPACE'] in the .env file.
  ///
  /// Fallback value: ['at_skeleton_app']
  ///
  /// Namespace is used to filter by an app's namespace from the secondary server.
  /// This value should be an @sign that you own (without the '@' symbol).
  /// By owning the @sign, you enforce that you also own the namespace.
  /// The namespace is invisible to the app user, so any @sign will suffice.
  static final String appNamespace = getEnv('NAMESPACE', fallback: 'at_skeleton_app');

  /// Returns the value for ['API_KEY'] in the .env file.
  ///
  /// Fallback value: [null]
  ///
  /// This is api key used to generate free @signs by at_onboarding_flutter.
  static final String? appApiKey = getEnv('API_KEY');

  /// Returns [RootEnvironment.Production] if [appApiKey] has a value.
  /// Returns [RootEnvironment.Staging] if [appApiKey] is null.
  ///
  /// Used by [Onboarding] from at_onboarding_flutter package in the templates.
  ///
  /// N.B. You should have your [API_KEY] set before publishing to the stores,
  /// otherwise the free @sign generator will not work.
  static RootEnvironment get rootEnvironment =>
      (appApiKey == null) ? RootEnvironment.Staging : RootEnvironment.Production;

  /// Returns the value for [key] in the .env file.
  ///
  /// Returns [fallback] if there is no value, or the value is null.
  ///
  /// Can be used to get additional values from the .env file.
  static dynamic getEnv(String key, {dynamic fallback}) {
    try {
      dynamic result = dotenv.maybeGet(key);
      if (result == null) return fallback;
      return result;
    } catch (_) {
      return fallback;
    }
  }
}
