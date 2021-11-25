import '../util/printer.dart';
import 'package:logger/logger.dart';

class LoggerService {
  static final LoggerService _singleton = LoggerService._();
  LoggerService._();
  factory LoggerService() => _singleton;

  final Logger logger = Logger(filter: ProductionFilter(), printer: Printer());
}
