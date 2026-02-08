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
import 'package:flutter_app_identity/android/android_ids.dart';
import 'package:flutter_app_identity/android/android_names.dart';
import 'package:flutter_app_identity/android/android_package_refactor.dart';
import 'package:flutter_app_identity/ios/ios_ids.dart';
import 'package:flutter_app_identity/ios/ios_names.dart';
import 'package:flutter_app_identity/utils/logger.dart';

void runFlutterAppIdentity() {
  Logger.info('flutter_app_identity v0.1.3');
  final config = RenameConfig.load();

  renameAndroidIds(config);
  renameAndroidNames(config);
  refactorAndroidPackage(config);
  renameIOSIds(config);
  renameIOSNames(config);

  Logger.success('✔ App identity updated successfully');
}
