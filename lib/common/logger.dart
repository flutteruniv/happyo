import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

final logger = Logger();

class Logger {
  static final Logger _logger = Logger._();

  Logger._();

  factory Logger() {
    return _logger;
  }

  void verbose(String message, {Object? args}) {
    _log(_LogEvent(
      message: message,
      args: args,
      level: _LogLevel.verbose,
    ));
  }

  void debug(String message, [Object? args]) {
    _log(_LogEvent(
      message: message,
      args: args,
      level: _LogLevel.debug,
    ));
  }

  void info(String message, {Object? args}) {
    _log(_LogEvent(
      message: message,
      args: args,
      level: _LogLevel.info,
    ));
  }

  void error(String message, {Object? args}) {
    _log(_LogEvent(
      message: message,
      args: args,
      level: _LogLevel.error,
    ));
  }

  void _log(_LogEvent event) {
    if (event.shouldWrite) {
      debugPrint(event.logLine);
    }
  }
}

class _LogEvent {
  String message;
  Object? args;
  _LogLevel level;
  final DateTime _now = DateTime.now();
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss S');

  _LogEvent({
    required this.message,
    this.args,
    this.level = _LogLevel.verbose,
  });

  String get logLine {
    if (args == null) {
      return "${_dateFormat.format(_now)} [$_level] $message";
    } else {
      return "${_dateFormat.format(_now)} [$_level] $message $args";
    }
  }

  bool get shouldWrite {
    return true;
  }

  String get _level {
    switch (level) {
      case _LogLevel.verbose:
        return "VERBOSE";
      case _LogLevel.debug:
        return "DEBUG";
      case _LogLevel.info:
        return "INFO";
      case _LogLevel.error:
        return "ERROR";
      default:
        return "NONE";
    }
  }
}

enum _LogLevel {
  verbose,
  debug,
  info,
  error,
}
