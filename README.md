# Assignment of Module 6 : Notes Management App (Flutter and Cloud Firestore)

# The application allow users to 
    - create
    - view
    - update
    - delete notes. 

# Requirements
### Each note contain:
    - Title
    - Description

# Features:
    - Create Note(Users can add a new note by providing a title and description also can update)
    - View Notes(All saved notes displayed in a list)
    - Update Note(Users are able to edit existing notes)
    - Delete Note(Users are able to remove notes from the database)
    - Displays all notes stored in Firestore

# Security
### This repo includes a Firebase API key which should not be exposed so that I restricted the api key in google cloud console. So the key is visible, but it cannot be misused outside this app.

# How to run
## 1. Clone the repository
git clone https://github.com/SumaiyaTabassum-1520/notes_management_app.git
cd notes_management_app

## 2. Install dependencies
flutter pub get

## 3. Run the app
flutter run