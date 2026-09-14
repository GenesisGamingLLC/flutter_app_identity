/*
    flutter_app_identity, A Flutter CLI tool to manage your app’s identity in one place.
    Copyright (C) 2026  Genesis Gaming LLC.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import 'dart:io';

/// Utility class to handle dry-run mode operations.
///
/// When dry-run mode is enabled, filesystem changes are not performed.
/// Instead, the intended operations are logged.
class DryRun {
  /// Whether dry-run mode is currently enabled.
  static bool enabled = false;

  /// Enables dry-run mode.
  static void enable() {
    enabled = true;
  }

  /// Disables dry-run mode.
  static void disable() {
    enabled = false;
  }

  /// Logs a dry-run operation.
  static void logOperation(String operation, String details) {
    if (enabled) {
      stdout.writeln('[DRY-RUN] $operation: $details');
    }
  }

  /// Writes a file unless dry-run mode is enabled.
  static void writeFile(
    File file,
    String contents, {
    String? description,
  }) {
    if (enabled) {
      logOperation(
        'Write file',
        description ?? file.path,
      );
      return;
    }

    file.writeAsStringSync(contents);
  }

  /// Creates a directory unless dry-run mode is enabled.
  static void createDirectory(
    Directory directory, {
    bool recursive = true,
    String? description,
  }) {
    if (enabled) {
      logOperation(
        'Create directory',
        description ?? directory.path,
      );
      return;
    }

    directory.createSync(recursive: recursive);
  }

  /// Deletes a file unless dry-run mode is enabled.
  static void deleteFile(
    File file, {
    String? description,
  }) {
    if (enabled) {
      logOperation(
        'Delete file',
        description ?? file.path,
      );
      return;
    }

    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  /// Deletes a directory unless dry-run mode is enabled.
  static void deleteDirectory(
    Directory directory, {
    String? description,
  }) {
    if (enabled) {
      logOperation(
        'Delete directory',
        description ?? directory.path,
      );
      return;
    }

    if (directory.existsSync()) {
      directory.deleteSync();
    }
  }
}
