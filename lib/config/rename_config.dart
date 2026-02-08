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

class RenameConfig {
  final String name;
  final String shortName;
  final String androidId;
  final String iosId;

  RenameConfig({
    required this.name,
    required this.shortName,
    required this.androidId,
    required this.iosId,
  });

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
