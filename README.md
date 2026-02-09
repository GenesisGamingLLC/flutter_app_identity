# flutter_app_identity

A Flutter CLI tool to manage your app’s **identity** in one place.

`flutter_app_identity` lets you configure:

- App name (long + short)
- Android applicationId
- iOS bundle identifier

All from `pubspec.yaml`.

---

## ✨ Why this exists

Flutter apps store identity in multiple platform-specific files.
Renaming an app manually is error-prone and inconsistent.

This tool:

- Enforces valid configurations
- Prevents ambiguous IDs
- Updates Android & iOS safely
- Works with modern Flutter (Kotlin-first)

---

## 📦 Installation

Add to your Flutter project:

```bash
flutter pub add dev:flutter_app_identity
```

## 🚀 Usage

Add config to `pubspec.yaml`:

```yaml
flutter_app_identity:
  name: "My Cool App"
  shortName: "Cool"
  id: "com.example.my_app"
  # Or for different ios and android IDs
  # If you have id above set, do not use the platform specific tags and vise versa.
  droidAppId: "com.example.droid"
  iosAppId: "com.example.ios"
```

Then run

```bash
dart run flutter_app_identity
```
