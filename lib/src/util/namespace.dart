import 'package:args/command_runner.dart';
import 'package:at_commons/at_commons.dart';
import 'package:at_utils/at_utils.dart';

String normalizeNamespace(String namespace) {
  try {
    String atsign = AtUtils.fixAtSign(namespace);
    return atsign.split('@')[1];
  } on InvalidAtSignException {
    throw UsageException(
      'Invalid value for namespace.',
      'Please use a valid @sign as your namespace.',
    );
  }
}
