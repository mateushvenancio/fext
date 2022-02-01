class ArgumentsFormatters {
  final List<String> arguments;

  ArgumentsFormatters(this.arguments);

  String get command {
    if (arguments.isEmpty) return 'version';
    return arguments.first;
  }

  List<String> get parameters {
    return arguments.skip(1).where((e) => !e.contains(RegExp('^[-][a-zA-Z]+'))).toList();
  }

  List<String> get flags {
    return arguments.skip(1).where((e) => e.contains(RegExp('^[-][a-zA-Z]+'))).toList();
  }
}
