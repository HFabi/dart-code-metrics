import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_code_metrics/src/cli/arguments_validation_exceptions.dart';

/// Umbrella method to run all checks
/// throws [InvalidArgumentsException]
void validateArguments(ArgResults arguments) {
  checkPathsToAnalyzeNotEmpty(arguments);
  checkPathsExistAndDirectories(arguments);
  // TODO: check that directories to analyze are all children of root folder
}

void checkPathsToAnalyzeNotEmpty(ArgResults arguments) {
  if (arguments.rest.isEmpty) {
    throw InvalidArgumentException(
        'Invalid number of directories. At least one must be specified');
  }
}

void checkPathsExistAndDirectories(ArgResults arguments) {
  arguments.rest.forEach((p) {
    if (!Directory(p).existsSync()) {
      throw InvalidArgumentException("$p doesn't exist or isn't a directory");
    }
  });
}
