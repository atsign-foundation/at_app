/// An exception thrown when the Flutter cli exits with a non-zero code
class FlutterException implements Exception {
  final String message;

  FlutterException(this.message);
}
