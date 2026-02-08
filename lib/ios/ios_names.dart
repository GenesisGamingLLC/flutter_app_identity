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

import 'package:flutter_app_identity/config/rename_config.dart';
import 'package:flutter_app_identity/utils/file_edit.dart';
import 'package:flutter_app_identity/utils/logger.dart';

void renameIOSNames(RenameConfig config) {
  replaceInFile(
    'ios/Runner/Info.plist',
    RegExp(r'<key>CFBundleName</key>\s*<string>.*?</string>'),
    '<key>CFBundleName</key>\n\t<string>${config.name}</string>',
  );
  replaceInFile(
    'ios/Runner/Info.plist',
    RegExp(r'<key>CFBundleDisplayName</key>\s*<string>.*?</string>'),
    '<key>CFBundleDisplayName</key>\n\t<string>${config.shortName}</string>',
  );
  Logger.success('iOS app names updated');
}
