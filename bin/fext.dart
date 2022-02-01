import 'src/arguments_formatters.dart';
import 'src/commands.dart';

void main(List<String> arguments) {
  ArgumentsFormatters formatter = ArgumentsFormatters(arguments);
  _run(formatter);
}

void _run(ArgumentsFormatters formatter) {
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
      runner.mobxBuild();
      break;
    case 'watch':
      runner.mobxWatch();
      break;
    default:
      runner.version();
  }
}
