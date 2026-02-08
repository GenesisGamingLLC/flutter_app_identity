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

void renameAndroidNames(RenameConfig config) {
  // 1️⃣ Ensure res/values/strings.xml exists
  final valuesDir =
      Directory(p.join('android', 'app', 'src', 'main', 'res', 'values'));
  if (!valuesDir.existsSync()) valuesDir.createSync(recursive: true);

  final stringsFile = File(p.join(valuesDir.path, 'strings.xml'));
  stringsFile.writeAsStringSync('''<?xml version='1.0' encoding='utf-8'?>
<resources>
    <string name="app_name">${config.name}</string>
    <string name="launcher_name">${config.shortName}</string>
    <string name="activity_name">@string/launcher_name</string>
</resources>
''');
  Logger.success('✅ Android strings.xml created/updated');

  // 2️⃣ Update AndroidManifest.xml
  final manifestPath =
      p.join('android', 'app', 'src', 'main', 'AndroidManifest.xml');
  final manifestFile = File(manifestPath);
  if (!manifestFile.existsSync()) {
    Logger.warn('AndroidManifest.xml not found at $manifestPath');
    return;
  }

  String content = manifestFile.readAsStringSync();

  // 2a. Update <application> android:label and android:name
  content = content.replaceAllMapped(
    RegExp(r'<application([^>]*)>'),
    (m) {
      var attrs = m.group(1)!;
      // Add/replace android:label
      if (attrs.contains('android:label=')) {
        attrs = attrs.replaceAll(RegExp(r'android:label="[^"]*"'),
            'android:label="@string/app_name"');
      } else {
        attrs += ' android:label="@string/app_name"';
      }
      return '<application$attrs>';
    },
  );

  // 2b. Update <activity> android:label
  content = content.replaceAllMapped(
    RegExp(r'<activity([^>]*)>'),
    (m) {
      var attrs = m.group(1)!;
      if (attrs.contains('android:label=')) {
        attrs = attrs.replaceAll(RegExp(r'android:label="[^"]*"'),
            'android:label="@string/activity_name"');
      } else {
        attrs += ' android:label="@string/activity_name"';
      }
      return '<activity$attrs>';
    },
  );

  // 2c. Update <intent-filter> android:label
  content = content.replaceAllMapped(
    RegExp(r'<intent-filter([^>]*)>'),
    (m) {
      var attrs = m.group(1)!;
      if (attrs.contains('android:label=')) {
        attrs = attrs.replaceAll(RegExp(r'android:label="[^"]*"'),
            'android:label="@string/launcher_name"');
      } else {
        attrs += ' android:label="@string/launcher_name"';
      }
      return '<intent-filter$attrs>';
    },
  );

  manifestFile.writeAsStringSync(content);
  Logger.success('✅ AndroidManifest.xml updated with labels and namespace');
}
