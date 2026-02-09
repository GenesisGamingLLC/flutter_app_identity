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

library android_ids;

import 'package:flutter_app_identity/config/rename_config.dart';
import 'package:flutter_app_identity/utils/file_edit.dart';
import 'package:flutter_app_identity/utils/logger.dart';

/// Renames the Android application ID and namespace in the build.gradle files.
///
/// This function updates the `applicationId` and `namespace` in both Groovy
/// (`build.gradle`) and Kotlin DSL (`build.gradle.kts`) files to match the
/// provided [config.androidId].
///
/// [config] - The configuration containing the new Android ID.
void renameAndroidIds(RenameConfig config) {
  // Groovy
  replaceInFile(
    'android/app/build.gradle',
    RegExp(r'applicationId\s+"[^"]+"'),
    'applicationId "${config.androidId}"',
  );

  replaceInFile(
    'android/app/build.gradle',
    RegExp(r'namespace\s+"[^"]+"'),
    'namespace "${config.androidId}"',
  );

  // Kotlin DSL (Flutter 3.38+)
  replaceInFile(
    'android/app/build.gradle.kts',
    RegExp(r'applicationId\s*=\s*"[^"]+"'),
    'applicationId = "${config.androidId}"',
  );

  replaceInFile(
    'android/app/build.gradle.kts',
    RegExp(r'namespace\s*=\s*"[^"]+"'),
    'namespace = "${config.androidId}"',
  );

  Logger.success('Android applicationId → ${config.androidId}');
}
