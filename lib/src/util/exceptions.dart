/// An exception thrown when the android configuration fails to update
class AndroidBuildException implements Exception {
  final String message = 'Unable to update the android build configuration.';
}

/// An exception thrown when the environment variables fail to set
class EnvException implements Exception {
  final String message = 'Unable to update the environment variables.';
}

/// An exception thrown when a template file fails to be copied
class TemplateFileException implements Exception {
  final String message = 'Unable to replace project with the template.';
}

/// An exception thrown when a package is not found in the pub cache
class NoPackageException implements Exception {
  final String message;

  NoPackageException(String packageName)
      : message = 'No version of $packageName found in the pub cache.';
}
