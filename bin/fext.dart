import 'src/arguments_formatters.dart';
import 'src/commands.dart';

void main(List<String> arguments) {
  ArgumentsFormatters formatter = ArgumentsFormatters(arguments);
  _run(formatter);
}

Future<void> _run(ArgumentsFormatters formatter) async {
  CommandsRunner runner = CommandsRunner(
    parameters: formatter.parameters,
    flags: formatter.flags,
  );

  if (!runner.flutter) {
    print('Run it on a flutter project');
    return;
  }

  switch (formatter.command) {
    case 'teste':
      runner.testando();
      break;
    case 'add':
      runner.installPackages();
      break;
    case 'clean':
      runner.clean();
      break;
    case 'build':
      runner.clean();
      break;
    case 'watch':
      runner.clean();
      break;
    default:
      runner.version();
  }
}
