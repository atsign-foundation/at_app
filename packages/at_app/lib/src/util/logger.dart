import 'dart:convert' show JsonEncoder;

import 'package:logger/logger.dart' show Logger, ProductionFilter, Level, LogEvent, LogPrinter;
import 'package:chalk/chalk.dart';

class LoggerService {
  static final LoggerService _singleton = LoggerService._();
  LoggerService._();
  factory LoggerService() => _singleton;

  final Logger logger = Logger(filter: ProductionFilter(), printer: _Printer());
}

class _Printer extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    var message = _buildMessage(event);
    if (event.level == Level.error) {
      message.first = '${chalk.red("[X]")} Error: ${message.first}';
    } else if (event.level == Level.warning) {
      message.first = '${"chalk.yellow([!])"} Warning: ${message.first}';
    }
    return message;
  }

  List<String> _buildMessage(LogEvent event) {
    return [
      _encodeMessage(event.message),
      if (event.error != null) _encodeMessage(event.error),
      if (event.stackTrace != null) _encodeMessage(event.stackTrace),
    ];
  }

  String _encodeMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      var encoder = const JsonEncoder.withIndent(null);
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }
}
