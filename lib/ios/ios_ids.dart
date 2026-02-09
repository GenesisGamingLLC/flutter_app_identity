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

/// Renames the iOS bundle identifier in the Xcode project file.
///
/// This function updates the `PRODUCT_BUNDLE_IDENTIFIER` in the
/// `ios/Runner.xcodeproj/project.pbxproj` file to match the provided [config.iosId].
///
/// [config] - The configuration containing the new iOS bundle ID.
void renameIOSIds(RenameConfig config) {
  replaceInFile(
    'ios/Runner.xcodeproj/project.pbxproj',
    RegExp(r'PRODUCT_BUNDLE_IDENTIFIER = [^;]+;'),
    'PRODUCT_BUNDLE_IDENTIFIER = ${config.iosId};',
  );
  Logger.success('iOS bundleId → ${config.iosId}');
}
