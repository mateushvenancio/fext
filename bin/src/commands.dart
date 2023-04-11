import 'dart:io';
import 'package:process_run/shell.dart';

import 'logger.dart';

class CommandsRunner {
  final List<String> parameters;
  final List<String> flags;

  final logger = Logger();

  final shell = Shell(
    commandVerbose: false,
    verbose: false,
  );
  final _clean = 'flutter clean';
  final _pubGet = 'flutter pub get';

  CommandsRunner({required this.parameters, required this.flags});

  bool get flutter {
    Directory dir = Directory(Directory.current.path + '\\pubspec.yaml');
    return File(dir.path).existsSync();
  }

  void testando() => logger.log('Testando\nParametros: $parameters\nFlags: $flags');

  void version() => logger.log('Version 1.0.0 - Made by MateusV');

  Future<void> installPackages() async {
    final dev = flags.contains('-d');

    for (var parameter in parameters) {
      logger.log('Installing $parameter...');
      await shell.run('flutter pub add $parameter ${dev ? '--dev' : ''}');
    }
  }

  Future<void> mobxBuild() async {
    final _build = 'flutter pub run build_runner build --delete-conflicting-outputs';

    try {
      logger.log('Building mobx...');
      await shell.run(_clean);
      await shell.run(_pubGet);
      await shell.run(_build);
      logger.log('Building mobx... Done!');
    } catch (e) {
      logger.log('Error building mobx: $e', level: Level.error);
    }
  }

  Future<void> mobxWatch() async {
    final _build = 'flutter pub run build_runner watch --delete-conflicting-outputs';

    try {
      logger.log('Watching mobx...');
      await shell.run(_clean);
      await shell.run(_pubGet);
      await shell.run(_build);
    } catch (e) {
      logger.log('Error watching mobx: $e', level: Level.error);
    }
  }

  Future<void> clean() async {
    try {
      logger.log('Cleaning...');
      await shell.run(_clean);
      await shell.run(_pubGet);
      logger.log('Cleaning... done!', erasePrevLine: true);
    } catch (e) {
      logger.log('Error: $e', level: Level.error);
    }
  }

  Future<void> generateApk() async {
    try {
      logger.log('Cleaning...');
      await shell.run(_clean);
      await shell.run(_pubGet);
      logger.log('Cleaning... done!', erasePrevLine: true);
      logger.log('Generating apk...');
      await shell.run('flutter build apk');
      logger.log(
        'Generating apk... '
        'Apk generated! Output: build\\app\\outputs\\flutter-apk\\app-release.apk',
        erasePrevLine: true,
      );
    } catch (e) {
      logger.log('Error: $e', level: Level.error);
    }
  }
}
