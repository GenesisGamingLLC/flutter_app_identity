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

/// Validates a bundle identifier (app ID) format.
///
/// The ID must start with a lowercase letter, followed by lowercase letters,
/// digits, or underscores, and contain at least one dot-separated segment.
///
/// [id] - The bundle ID to validate.
/// Throws an exception if the ID is invalid.
void validateBundleId(String id) {
  final regex = RegExp(
    r'^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$',
  );

  if (!regex.hasMatch(id)) {
    throw Exception('Invalid app identifier: $id');
  }
}
