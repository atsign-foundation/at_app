import 'dart:convert';

import 'package:logger/logger.dart';

class Printer extends LogPrinter {
  static final levelColors = {
    Level.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
    Level.debug: AnsiColor.none(),
    Level.info: AnsiColor.fg(12),
    Level.warning: AnsiColor.fg(208),
    Level.error: AnsiColor.fg(196),
    Level.wtf: AnsiColor.fg(199),
  };

  @override
  List<String> log(LogEvent event) {
    var messageStr = _stringifyMessage(event.message);
    var errorStr = event.error != null ? '  ERROR: ${event.error}' : '';
    return ['${_labelFor(event.level)}$messageStr$errorStr'];
  }

  String _labelFor(Level level) {
    switch (level) {
      case Level.error:
        return '[!] ERROR: ';
      case Level.warning:
        return '[!] Warning: ';
      default:
        return '';
    }
  }

  String _stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      var encoder = JsonEncoder.withIndent(null);
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }
}
