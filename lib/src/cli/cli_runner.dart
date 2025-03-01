import 'dart:io';

import 'package:args/command_runner.dart';

import 'commands/analyze_command.dart';
import 'commands/check_unused_files_command.dart';
import 'commands/check_unused_l10n_command.dart';

/// Represents a cli runner responsible
/// for running a command based on raw cli call data.
class CliRunner extends CommandRunner<void> {
  static final _commands = [
    AnalyzeCommand(),
    CheckUnusedFilesCommand(),
    CheckUnusedL10nCommand(),
  ];

  CliRunner()
      : super(
          'metrics',
          'Analyze and improve your code quality.',
        ) {
    _commands.forEach(addCommand);
  }

  /// Represents the invocation string message
  @override
  String get invocation => '${super.invocation} <directories>';

  /// Main entry point for running a command
  @override
  Future<void> run(Iterable<String> args) async {
    try {
      await super.run(_addDefaultCommand(args));
    } on UsageException catch (e) {
      print('${e.message}\n');
      print('${e.usage}\n');
      exit(64);
    } on Exception catch (e) {
      print('Oops; metrics has exited unexpectedly: "$e"');
      exit(1);
    }
  }

  Iterable<String> _addDefaultCommand(Iterable<String> args) => args.isEmpty
      ? args
      : !commands.keys.contains(args.first)
          ? ['analyze', ...args]
          : args;
}
