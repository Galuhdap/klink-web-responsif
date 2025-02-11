# SIM KLINIK CHANIA CARE CENTER Project Flutter

## Author
Galuh Dwi Agung Putra 

## Date
1 February 2024

## Project Description
SIM KLINIK CHANIA CARE CENTER


## Getting started

**Prerequisites :**

- Flutter SDK : 3.27.4
- IDE of your choice (e.g., VS Code, or Android Studio)

- add in dev_dependencies
  - build_runner: ^2.4.14
  - flutter_gen_runner: ^5.9.0

- when you add image static or icon just run 
   - dart run build_runner build

**Installation :**

1. Clone the repository
`git clone` https://github.com/Galuhdap/klink-web-responsif
2. Navigate to project directory
`cd klink-web-responsif`
3. Install Dependencies
`flutter pub get`

**Running the Application :**
1. Connect a device or emulator
2. Run the app `flutter run`

**Launch Settings**

1. **VS Code**

        {
            "name": "SIM Klinik C3",
            "type": "dart",
            "request": "launch",
            "program": "lib/main_prod.dart",
            "args": [
                "--flavor",
                "prod"
               
            ]
        },      
        {
            "name": "Dev SIM Klinik C3",
            "type": "dart",
            "request": "launch",
            "program": "lib/main_dev.dart",
            "args": [
                "--flavor",
                "dev"
               
            ]
        }

2. **Android Studio**

`--flavor prod --no-enable-impeller`

# Create appBundle for Android platform. Runs in release mode by default.

build appbundle dev: flutter build appbundle -t lib/main_dev.dart --flavor=dev --no-shrink
build appbundle prod: flutter build appbundle -t lib/main_prod.dart --no-tree-shake-icons --flavor=prod --no-shrink

# Create APK for dev / prod flavor. Runs in release mode by default.

build apk dev : flutter build apk -t lib/main_dev.dart --flavor dev --split-per-abi --no-shrink
build apk prod : flutter build apk -t lib/main_prod.dart --flavor prod --split-per-abi --no-shrink