const flutterArgs = <String>[
  'pub',
  'offline',
  'overwrite',
  'decription',
  'org',
  'project-name',
  'ios-language',
  'android-language',
  'platforms',
];

const atAppArgs = <String>[
  'overwrite', // Overwrite is part of both
  'namespace',
  'root-domain',
  'api-key',
];

// Copyright 2014 The Flutter Authors. All rights reserved.
const List<String> kAvailablePlatforms = <String>[
  'ios',
  'android',
  'windows',
  'linux',
  'macos',
  // 'web',
];

// Copyright 2014 The Flutter Authors. All rights reserved.
const List<String> kAllCreatePlatforms = <String>[
  'ios',
  'android',
  'windows',
  'linux',
  'macos',
  // 'web',
  'winuwp',
];

// Copyright 2014 The Flutter Authors. All rights reserved.
const String kPlatformHelp =
  'The platforms supported by this project. '
  'Platform folders (e.g. android/) will be generated in the target project. '
  'This argument only works when "--template" is set to app or plugin. '
  'When adding platforms to a plugin project, the pubspec.yaml will be updated with the requested platform. '
  'Adding desktop platforms requires the corresponding desktop config setting to be enabled.';
