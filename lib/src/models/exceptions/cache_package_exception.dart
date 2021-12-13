/// An exception thrown when a package is not found in the pub cache
class CachePackageException implements Exception {
  final String message;

  CachePackageException(String packageName) : message = 'Unable to retrieve package: $packageName';
}
