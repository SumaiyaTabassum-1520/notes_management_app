# Notes Management App (Flutter + Cloud Firestore)

A simple CRUD notes app. Each note has a **title** and **description**,
stored in a Firestore collection called `notes`.

## Project Structure

```
lib/
  main.dart                        # App entry point, initializes Firebase
  models/
    note.dart                      # Note data model (toMap / fromDocument)
  services/
    firestore_service.dart         # All Firestore CRUD calls live here
  screens/
    notes_list_screen.dart         # Screen 1: list all notes (StreamBuilder)
    add_edit_note_screen.dart      # Screen 2: create OR edit a note
```

## How the CRUD maps to the code

| Operation | Where |
|---|---|
| Create | `FirestoreService.addNote()` → called from `AddEditNoteScreen` when `note == null` |
| Read | `FirestoreService.getNotes()` returns a `Stream<List<Note>>` consumed by a `StreamBuilder` in `NotesListScreen` (updates live, no manual refresh needed) |
| Update | `FirestoreService.updateNote()` → called from `AddEditNoteScreen` when editing an existing note |
| Delete | `FirestoreService.deleteNote()` → called from the delete icon / confirmation dialog in `NotesListScreen` |

## Setup Steps

### 1. Create the Flutter project (if starting fresh)
If you don't already have a Flutter project, run:
```bash
flutter create notes_app
```
Then copy the `lib/` folder and `pubspec.yaml` from this assignment into it,
overwriting the defaults.

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Create a Firebase project
1. Go to https://console.firebase.google.com and create a new project.
2. Enable **Cloud Firestore** (Build → Firestore Database → Create database → start in test mode for development).

### 4. Connect Flutter to Firebase (recommended: FlutterFire CLI)
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```
This walks you through selecting your Firebase project and platforms
(Android/iOS/web), and generates `lib/firebase_options.dart` automatically.

Then update `lib/main.dart`:
```dart
import 'firebase_options.dart';
...
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
```

### 5. Manual setup alternative (if not using the CLI)
- **Android**: download `google-services.json` from Firebase Console → place it in `android/app/`. Add the Google services Gradle plugin per Firebase docs.
- **iOS**: download `GoogleService-Info.plist` → place it in `ios/Runner/` via Xcode.

### 6. Firestore Security Rules (for development only)
In the Firebase Console → Firestore → Rules:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /notes/{noteId} {
      allow read, write: if true; // NOTE: open for development only
    }
  }
}
```
Tighten this before shipping to production (e.g., require authentication).

### 7. Run the app
```bash
flutter run
```

## Notes / Possible Extensions
- Timestamps (`createdAt`, `updatedAt`) are already stored on each note using `FieldValue.serverTimestamp()`, so you could easily show "last edited" text.
- To add user-specific notes, add Firebase Authentication and filter the `notes` collection by a `userId` field.
- Validation currently just checks for non-empty fields; extend `add_edit_note_screen.dart` if you need length limits, etc.
