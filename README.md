# Listen First

A Flutter application that allows users to search for music on the iTunes Store and play previews.

![Simulator Screen Recording - iPhone SE (3rd generation) - 2025-05-09 at 12 23 28](https://github.com/user-attachments/assets/8253476e-675c-48bc-952d-0b05c0c54c82)

This project is deployed on GitHub Pages and can be accessed at (https://samantha9995.github.io/ListenFirst/).

## Features

*   **Search Music:** Search for songs, artists, and albums on the iTunes Store.
*   **Play Previews:** Listen to previews of the search results.
*   **Search History:** View and manage your search history.
*   **Localization:** Supports multiple languages (English and Chinese).
*   **Cross-Platform:** Runs on Android, iOS, and Web.

## Technologies Used

*   **Flutter:** UI framework.
*   **GetX:** State management and dependency injection.
*   **EasyLocalization:** Internationalization and localization.
*   **Hive:** Local data storage for search history.
*   **Just Audio:** Audio playback.
*   **Logger:** Logging.


## Localization

The app supports English (en\_US) and Chinese (zh\_TW). Localization files are located in the `langs` directory.

## State Management

The app uses GetX for state management. Controllers are located in the `lib/features/search/controllers` directory.

## Data Storage

The app uses Hive for local data storage. The `SearchHistoryModel` is used to store search history.

## Dependency Injection

The app uses a service locator pattern for dependency injection. The `setupServiceLocator` function in `lib/core/di/service_locator.dart` sets up the dependencies.

### Prerequisites

*   Flutter SDK (>=3.29.3, <4.0.0, includes Dart SDK >=3.7.2, <4.0.0)
*   iOS: Xcode (version 12 or higher)
*   Android SDK (API level 24 or higher)
*   Chrome 135.0.7049.117 (x86_64) or higher
*   An IDE like VS Code or Android Studio

### Installation

1.  Clone the repository:

    ```bash
    git clone git@github.com:Samantha9995/ListenFirst.git
    ```

2.  Navigate to the project directory:

    ```bash
    cd listen_first
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
Listen_first/
├── lib/
│ ├── core/
│ │ └── di/
│ │ └── service_locator.dart
│ ├── models/
│ │ └── search_result.dart
│ │ └── search_history.dart
│ ├── theme/
│ │ └── itunes_theme.dart
│ ├── services/
│ │ └── hive_service.dart
│ ├── utils/
│ │ ├── constants.dart
│ │ ├── logging_interceptor.dart
│ │ └── styles.dart
│ ├── widgets/
│ │ ├── about_me.dart
│ │ ├── custom_text.dart
│ │ ├── music_player.dart
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

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## License

Apache License Version 2.0

## Copyright

Copyright (c) 2025 SADev. All rights reserved.
