import 'dart:io';

/// Utility class to handle dry-run mode operations.
/// In dry-run mode, all operations are logged but not executed.
class DryRun {
  /// Whether dry-run mode is enabled.
  final bool enabled;

  DryRun({required this.enabled});

  /// Logs an operation without executing it.
  void logOperation(String operation, String details) {
    if (enabled) {
      stdout.writeln('[DRY-RUN] $operation: $details');
    }
  }

  /// Executes a function only if not in dry-run mode.
  T? executeIfNotDryRun<T>(T? Function() operation, String operationName) {
    if (enabled) {
      logOperation(operationName, 'Would execute');
      return null;
    } else {
      return operation();
    }
  }

  /// Executes a function only if not in dry-run mode.
  void executeIfNotDryRunVoid(Function() operation, String operationName) {
    if (enabled) {
      logOperation(operationName, 'Would execute');
    } else {
      operation();
    }
  }
}
