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
import 'package:flutter_app_identity/utils/dry_run.dart';

/// Replaces all occurrences of [from] with [to] in the file at [path].
///
/// If the file does not exist, this function does nothing.
///
/// In dry-run mode, the file is read and the replacement is calculated,
/// but the file is not modified.
///
/// [path] - The path to the file to edit.
/// [from] - The pattern to replace.
/// [to] - The replacement string.
void replaceInFile(String path, Pattern from, String to) {
  final file = File(path);

  if (!file.existsSync()) {
    return;
  }

  final content = file.readAsStringSync();
  final updatedContent = content.replaceAll(from, to);

  // Nothing actually changes.
  if (updatedContent == content) {
    DryRun.logOperation(
      'No change',
      path,
    );
    return;
  }

  DryRun.writeFile(
    file,
    updatedContent,
    description: 'Replace content in $path',
  );
}
