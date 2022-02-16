import '../../at_app.dart';

/// This file contains all @platform packages sorted into three categories

/// All flutter based @platform packages
/// Designed to be included in an app
const List<List<String>> flutterPackages = [
  [
    'at_client_mobile',
    'The @platform SDK with device specific features for iOS and Android applications.',
  ],
  [
    'at_onboarding_flutter',
    'A Flutter plugin project to cover the onboarding flow of @protocol apps.',
  ],
  [
    'at_backup_key_flutter',
    'A Flutter plugin that provides backup keys of an @sign generated during onboarding flow of @protocol.',
  ],
  [
    'at_contacts_flutter',
    'A Flutter plugin project for CRUD operations on contacts.',
  ],
  [
    'at_contacts_group_flutter',
    'A Flutter plugin to provide group functionality for atsign contacts. Helps to manage contacts.',
  ],
  [
    'at_chat_flutter',
    'A Flutter plugin to provide chat feature between two atsigns.',
  ],
  [
    'at_location_flutter',
    'A Flutter plugin project to share location between two atsigns.',
  ],
  [
    'at_events_flutter',
    'A Flutter plugin project to manage events.',
  ],
  [
    'at_follows_flutter',
    'A Flutter plugin project to integrate follows feature for @signs.',
  ],
  [
    'at_invitation_flutter',
    'A Flutter package to share data and invite contacts using SMS or email to the @platform.',
  ],
  [
    'at_theme_flutter',
    'A Flutter plugin project to provide theme selection in @‎platform apps with ease.',
  ],
  [
    'at_notify_flutter',
    'A Flutter plugin project to handle notifications in @protocol apps.',
  ],
];

/// All utility based @platform packages
/// May be included and used in an app
const List<List<String>> utilPackages = [
  [
    'at_commons',
    'Contains commonly used components in the implementation of the @protocol.',
  ],
  [
    'at_server_status',
    'A library that allows you to check the status of a secondary server or the root server.',
  ],
  [
    'at_utils',
    'utility classes for atsign, atmetadata, configuration and logger.',
  ],
  [
    'at_demo_data',
    'A library that provides demo data when using the @platform virtual environment',
  ],
  [
    atAppName,
    atAppDescription,
  ],
  [
    'at_app_flutter',
    'A package used by at_app to generate the app, and initialize the app environment',
  ],
  [
    'at_contact',
    'at_contact library persists contacts across different @platform applications.',
  ],
];

/// All core @platform packages
/// Not designed to be used directly in an app
const List<List<String>> corePackages = [
  [
    'at_client',
    'This SDK provides the essential methods for building an app using the @protocol',
  ],
  [
    'at_lookup',
    'The at_lookup Library is the low-level direct implementation of the @protocol verbs.',
  ],
  [
    'at_persistence_spec',
    'an interface abstraction that defines what an at_persistence implementation is responsible for.',
  ],
  [
    'at_persistence_secondary_server',
    'the persistence layer implementation for @protocol secondary server.',
  ],
  [
    'at_server_spec',
    'at_server_spec is an interface abstraction that defines what the @server is responsible for.',
  ],
  [
    'at_common_flutter',
    'A Flutter package to provide custom widgets for other @sign packages.',
  ],
];
