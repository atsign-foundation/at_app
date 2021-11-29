/// An exception thrown when the environment variables fail to set
class EnvException implements Exception {
  final String message = 'Unable to update the environment variables.';
}
