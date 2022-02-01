import 'dart:io';
import 'package:process_run/shell.dart';

class CommandsRunner {
  final List<String> parameters;
  final List<String> flags;

  final shell = Shell();
  final _clean = 'flutter clean';
  final _pubGet = 'flutter pub get';

  CommandsRunner({required this.parameters, required this.flags});

  bool get flutter {
    Directory dir = Directory(Directory.current.path + '\\pubspec.yaml');
    return File(dir.path).existsSync();
  }

  void testando() => print('Testando\nParametros: $parameters\nFlags: $flags');

  void version() => print('Version 1.0.0 - Made by MateusV');

  Future<void> installPackages() async {
    final dev = flags.contains('-d');

    for (var parameter in parameters) {
      print('Installing $parameter...');
      await shell.run('flutter pub add $parameter ${dev ? '--dev' : ''}');
    }
  }

  Future<void> mobxBuild() async {
    if (!flutter) {
      print('Run it on a flutter project');
      return;
    }

    final _build = 'flutter pub run build_runner build --delete-conflicting-outputs';

    try {
      print('Building mobx...');
      await shell.run('$_clean;$_pubGet;$_build');
      print('Building mobx... Done!');
    } catch (e) {
      print('Error building mobx: $e');
    }
  }

  Future<void> mobxWatch() async {
    if (!flutter) {
      print('Run it on a flutter project');
      return;
    }

    final _build = 'flutter pub run build_runner watch --delete-conflicting-outputs';

    try {
      print('Watching mobx...');
      await shell.run('$_clean;$_pubGet;$_build');
    } catch (e) {
      print('Error watching mobx: $e');
    }
  }

  Future<void> clean() async {
    if (!flutter) {
      print('Run it on a flutter project');
      return;
    }

    try {
      print('Cleaning...');
      await shell.run('$_clean;$_pubGet');
      print('Cleaning done!');
    } catch (e) {
      print('Error: $e');
    }
  }
}
