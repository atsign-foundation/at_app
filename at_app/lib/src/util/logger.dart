import 'dart:convert' show JsonEncoder;

import 'package:logger/logger.dart' show Logger, ProductionFilter, AnsiColor, Level, LogEvent, LogPrinter;

class LoggerService {
  static final LoggerService _singleton = LoggerService._();
  LoggerService._();
  factory LoggerService() => _singleton;

  final Logger logger = Logger(filter: ProductionFilter(), printer: _Printer());
}

class _Printer extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    var messageStr = _stringifyMessage(event.message ?? '');
    var errorStr = event.error ?? '';
    return [_color(event.level)('${_labelFor(event.level)}$messageStr$errorStr')];
  }

  AnsiColor _color(Level level) => {
        Level.verbose: AnsiColor.fg(AnsiColor.grey(0.5)),
        Level.debug: AnsiColor.none(),
        Level.info: AnsiColor.fg(12),
        Level.warning: AnsiColor.fg(208),
        Level.error: AnsiColor.fg(196),
        Level.wtf: AnsiColor.fg(199),
        Level.nothing: AnsiColor.none(),
      }[level]!;

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
      var encoder = const JsonEncoder.withIndent(null);
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }
}
