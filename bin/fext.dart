import 'dart:io';
import 'package:process_run/shell.dart';

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('Version: 1.0.0');
    return;
  }

  String command = arguments.first;

  try {
    if (command == 'add') {
      _installPackages(arguments.sublist(1));
    }
  } catch (e) {
    print('Error catch: $e');
  }
}

Future<void> _installPackages(List<String> packages) async {
  Directory dir = Directory(Directory.current.path + '\\pubspec.yaml');

  if (!File(dir.path).existsSync()) {
    print('Run it on a flutter project');
    return;
  }

  final shell = Shell();

  bool _dev = packages.contains('-d');

  for (String pkg in packages) {
    try {
      if (_dev) {
        await shell.run('flutter pub add $pkg --dev');
      } else {
        await shell.run('flutter pub add $pkg');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }
}
