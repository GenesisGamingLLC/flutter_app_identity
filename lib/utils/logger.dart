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

/// A simple logger class for outputting messages to the console.
///
/// This class provides static methods for logging different types of messages
/// with appropriate emojis.
class Logger {
  /// Logs an informational message.
  ///
  /// [msg] - The message to log.
  static void info(String msg) => print('ℹ️  $msg');

  /// Logs a success message.
  ///
  /// [msg] - The message to log.
  static void success(String msg) => print('✅ $msg');

  /// Logs a warning message.
  ///
  /// [msg] - The message to log.
  static void warn(String msg) => print('⚠️  $msg');
}
