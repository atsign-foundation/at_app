import '../../at_app.dart';

/// This file contains all @platform packages sorted by type
/// The map format is:
/// package_name: description

/// All flutter based @platform packages
/// Designed to be included in an app
const Map<String, String> flutterPackages = {
  'at_client_mobile': '',
  'at_onboarding_flutter': '',
  'at_common_flutter': '',
  'at_backup_key_flutter': '',
  'at_contacts_flutter': '',
  'at_contacts_group_flutter': '',
  'at_chat_flutter': '',
  'at_location_flutter': '',
  'at_events_flutter': '',
  'at_follows_flutter': '',
  'at_invitation_flutter': '',
  'at_theme_flutter': '',
  'at_notify_flutter': '',
};

/// All utility based @platform packages
/// May be included and used in an app
const Map<String, String> utilPackages = {
  'at_commons': '',
  'at_server_status': '',
  'at_utils': '',
  'at_demo_data': '',
  atAppName: atAppDescription,
  'at_app_flutter':
      'A package used by at_app to generate the app, and initialize the app environment',
};

/// All core @platform packages
/// Not designed to be used directly in an app
const Map<String, String> corePackages = {
  'at_client': '',
  'at_lookup': '',
  'at_persistence_spec': '',
  'at_persistence_secondary_server': '',
  'at_server_spec': '',
  'at_contact': '',
};
