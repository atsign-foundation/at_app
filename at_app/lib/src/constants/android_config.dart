/// The default android configuration for an at_app application

Map<String, dynamic> defaultAppBuildGradleOptions = {
  'targetSdkVersion': 30,
  'minSdkVersion': 24,
  'compileSdkVersion': 31,
};

Map<String, dynamic> defaultBuildGradleOptions = {
  'ext.kotlin_version': '1.4.31',
};

Map<String, dynamic> defaultGradlePropertiesOptions = {
  'android.enableR8': true,
};
