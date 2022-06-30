import 'package:logging/logging.dart';

// Class log debug
class AppLog {
  final String? className;

  static Logger? log;

  AppLog({this.className}) {
    log = Logger(className ?? "TGGT");

    Logger.root.level = Level.ALL; // defaults to Level.INFO
    // ignore: avoid_print

    Logger.root.onRecord.listen((record) {
      // ignore: avoid_print
      print(
          "------------------------------->STATR<-------------------------------");
      // ignore: avoid_print
      print(
          '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
      // ignore: avoid_print
      print(
          "------------------------------->END<--------------------------------");
    });
  }

  static info(dynamic message) {
    log?.info(message);
  }

  static warning(dynamic message) {
    log?.warning(message);
  }

  static config(String message) {
    log?.config(message);
  }

  /// Emit a [info] log event
  static printInfo(String info) {
    // ignore: avoid_print
    print('\u001b[32m[INFO]: $info\u001b[0m');
  }

  /// Emit a [warning] log event
  static printWarning(String warning) {
    // ignore: avoid_print
    print('\u001B[34m[WARNING]: $warning\u001b[0m');
  }

  /// Emit a [error] log event
  static printError(String error) {
    // ignore: avoid_print
    print('\u001b[31m[ERROR]: $error\u001b[0m');
  }
}
