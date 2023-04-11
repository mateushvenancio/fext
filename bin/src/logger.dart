import 'dart:io';

enum Level { info, error, warning }

class Logger {
  log(String value, {bool erasePrevLine = false, Level level = Level.info}) {
    if (erasePrevLine) {
      stdout.write(String.fromCharCode(0x1b) + '[1A' + String.fromCharCode(0x1b) + '[K');
    }
    stdout.writeln('\x1B[${_getColor(level)}m$value\x1B[0m');
  }

  String _getColor(Level level) {
    if (level == Level.info) return '92';
    if (level == Level.error) return '91';
    if (level == Level.warning) return '93';
    return '97';
  }
}
