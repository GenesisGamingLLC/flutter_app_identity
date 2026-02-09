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

library android_package_refactor;

import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:flutter_app_identity/config/rename_config.dart';
import 'package:flutter_app_identity/utils/logger.dart';

/// Refactors the Android package structure for Kotlin source files.
///
/// This function updates the package declarations in all `.kt` files under
/// `android/app/src/main/kotlin` to match the new [config.androidId], and moves
/// the files to the corresponding directory structure. It also cleans up empty
/// directories left behind.
///
/// [config] - The configuration containing the new Android ID.
void refactorAndroidPackage(RenameConfig config) {
  final kotlinRoot = Directory(
    p.join('android', 'app', 'src', 'main', 'kotlin'),
  );

  if (!kotlinRoot.existsSync()) {
    Logger.warn('No Kotlin source directory found');
    return;
  }

  final newPackage = config.androidId;
  final newPath = p.joinAll(newPackage.split('.'));

  final ktFiles = kotlinRoot
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.kt'))
      .toList();

  for (final file in ktFiles) {
    final content = file.readAsStringSync();

    final updated = content.replaceFirst(
      RegExp(r'^package\s+[\w.]+', multiLine: true),
      'package $newPackage',
    );

    final newFile = File(
      p.join(kotlinRoot.path, newPath, p.basename(file.path)),
    );

    newFile.parent.createSync(recursive: true);
    newFile.writeAsStringSync(updated);

    if (file.path != newFile.path) {
      file.deleteSync();
    }
  }

  _cleanupEmptyDirs(kotlinRoot);
  Logger.success('Android Kotlin package path refactored');
}

void _cleanupEmptyDirs(Directory dir) {
  for (final e in dir.listSync()) {
    if (e is Directory) {
      _cleanupEmptyDirs(e);
      if (e.listSync().isEmpty) {
        e.deleteSync();
      }
    }
  }
}
