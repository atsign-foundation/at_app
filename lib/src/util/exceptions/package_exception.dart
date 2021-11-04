/// An exception thrown when a package is not found in the pub cache
class PackageException implements Exception {
  final String message;

  PackageException(String packageName)
      : message = 'No version of $packageName found in the pub cache.';
}
