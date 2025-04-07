# iTunes Music Search App

This is a Flutter app that allows users to search for music on iTunes and play previews.

![Simulator Screen Recording - iPhone SE (3rd generation) - 2025-04-07 at 17 29 05](https://github.com/user-attachments/assets/c529df0c-b2d7-4b5d-8360-dc93ee1100e0)


## Features

*   Search for music by keyword
*   View search results with track details (artist, album, artwork)
*   Play music previews
*   Error handling for network issues and invalid search terms
*   Clean and responsive UI
*   Internationalization (i18n) and Localization (l10n) using the Easy localization

## Technologies Used

*   Flutter
*   Dart
*   GetX (state management)
*   GetIt
*   Dio (HTTP client)
*   Just Audio (audio playback)
*   Easy localization

## Getting Started

### Prerequisites

*   Flutter SDK (3.13.0 or higher)
*   Dart SDK (3.2.0 or higher, included with Flutter)
*   An IDE like VS Code or Android Studio

### Installation

1.  Clone the repository:

    ```bash
    git clone <your-repository-url>
    ```

2.  Navigate to the project directory:

    ```bash
    cd itunes_music_app
    ```

3.  Install dependencies:

    ```bash
    flutter pub get
    ```

### Running the App

1.  Connect a physical device or start an emulator.
2.  Run the app:

    ```bash
    flutter run
    ```

## Project Structure
```
itunes_music_app/
├── lib/
│ ├── core/
│ │ └── di/
│ │ └── service_locator.dart
│ ├── models/
│ │ └── search_result.dart
│ ├── theme/
│ │ └── itunes_theme.dart
│ ├── utils/
│ │ ├── constants.dart
│ │ ├── logging_interceptor.dart
│ │ └── styles.dart
│ ├── widgets/
│ │ ├── custom_text.dart
│ │ ├── search_bar.dart
│ │ └── search_result_tile.dart
│ ├── features/
│ │ └── search/
│ │ ├── controllers/
│ │ │ └── search_controller.dart
│ │ ├── repositories/
│ │ │ └── search_repository.dart
│ │ └── views/
│ │ └── search_page.dart
│ └── main.dart # Entry point of the app
├── pubspec.yaml # Project dependencies and configuration
├── README.md # Project documentation
└── ...
```

## State Management

This app uses GetX for state management. Key controllers:

*   `SearchMusicController`: Manages the search logic, search results, loading state, error messages, and audio playback.

## API Integration

The app uses the iTunes Search API to fetch music data. The `SearchRepository` class handles the API requests using the `Dio` package.
