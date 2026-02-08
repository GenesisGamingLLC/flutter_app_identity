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
import 'package:path/path.dart' as p;
import 'package:flutter_app_identity/config/rename_config.dart';
import 'package:flutter_app_identity/utils/logger.dart';

void refactorAndroidPackage(RenameConfig config) {
  final kotlinRoot =
      Directory(p.join('android', 'app', 'src', 'main', 'kotlin'));
  if (!kotlinRoot.existsSync()) {
    Logger.warn('No Kotlin directory found');
    return;
  }

  final newPackage = config.androidId;
  final newPackagePath = p.joinAll(newPackage.split('.'));

  final files = kotlinRoot
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.kt'))
      .toList();

  for (final file in files) {
    final content = file.readAsStringSync();
    final updated = content.replaceFirst(
      RegExp(r'^package\s+[\w.]+', multiLine: true),
      'package $newPackage',
    );

    final newFile =
        File(p.join(kotlinRoot.path, newPackagePath, p.basename(file.path)));
    newFile.parent.createSync(recursive: true);
    newFile.writeAsStringSync(updated);
    if (file.path != newFile.path) file.deleteSync();
  }

  _cleanup(kotlinRoot);
  Logger.success('Android Kotlin package refactored');
}

void _cleanup(Directory dir) {
  for (final e in dir.listSync()) {
    if (e is Directory) {
      _cleanup(e);
      if (e.listSync().isEmpty) e.deleteSync();
    }
  }
}
