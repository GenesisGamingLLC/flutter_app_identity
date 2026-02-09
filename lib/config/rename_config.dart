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

import 'package:flutter_app_identity/utils/yaml_loader.dart';
import 'package:flutter_app_identity/utils/validators.dart';

/// Configuration class for app identity renaming.
///
/// This class holds the configuration values loaded from the YAML file
/// for renaming the app's name, short name, Android ID, and iOS ID.
class RenameConfig {
  /// The full name of the app.
  final String name;

  /// The short name of the app (used for display).
  final String shortName;

  /// The Android application ID.
  final String androidId;

  /// The iOS bundle identifier.
  final String iosId;

  /// Creates a new [RenameConfig] instance.
  ///
  /// [name] - The full app name.
  /// [shortName] - The short app name.
  /// [androidId] - The Android app ID.
  /// [iosId] - The iOS bundle ID.
  RenameConfig({
    required this.name,
    required this.shortName,
    required this.androidId,
    required this.iosId,
  });

  /// Loads the configuration from the YAML file.
  ///
  /// This method reads the `flutter_app_identity` configuration from
  /// `pubspec.yaml` and validates the required fields.
  ///
  /// Returns a [RenameConfig] instance with the loaded values.
  /// Throws an exception if required fields are missing or invalid.
  static RenameConfig load() {
    final cfg = loadFlutterRenameConfig();
    final name = cfg['name'];
    if (name == null) throw Exception('flutter_app_identity.name is required');

    final shortName = cfg['shortName'] ?? name;
    final id = cfg['id'];
    final android = cfg['droidAppId'];
    final ios = cfg['iosAppId'];

    if (id != null && (android != null || ios != null)) {
      throw Exception('Use either id OR droidAppId + iosAppId');
    }
    if (id == null && (android == null || ios == null)) {
      throw Exception('Provide id or both droidAppId + iosAppId');
    }

    final androidId = id ?? android;
    final iosId = id ?? ios;

    validateBundleId(androidId);
    validateBundleId(iosId);

    return RenameConfig(
      name: name,
      shortName: shortName,
      androidId: androidId,
      iosId: iosId,
    );
  }
}
