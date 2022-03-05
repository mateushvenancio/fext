enum Level { info, error, warning }

class Logger {
  log(String value, [Level level = Level.info]) async {
    print('\x1B[${_getColor(level)}m$value\x1B[0m');
  }

  String _getColor(Level level) {
    if (level == Level.info) return '92';
    if (level == Level.error) return '91';
    if (level == Level.warning) return '93';
    return '97';
  }
}
