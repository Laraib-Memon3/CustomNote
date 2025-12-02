# CustomNote

CustomNote is a Flutter-based note-taking app focused on personalization, theme-based UI (Light, Dark, and Pastel modes), and productivity. Users can create, color-tag, and manage notes with a clean interface and scalable architecture for future features like reminders and backup sync.

## Features

- **Theme Management**: Support for Light, Dark, and Pastel theme modes
- **Note Management**: Create, edit, and delete notes with ease
- **Color Tags**: Assign color tags to notes for better organization
- **Search**: Search notes by title or content
- **Clean Architecture**: Modular folder structure following best practices

## Project Structure

```
lib/
├── core/                    # Core utilities and configurations
│   ├── constants/           # App-wide constants (colors, strings, dimensions)
│   ├── themes/              # Theme definitions and management
│   └── utils/               # Utility functions (date formatting, etc.)
├── data/                    # Data layer
│   ├── repositories/        # Repository implementations
│   └── services/            # Data services (local storage, etc.)
├── domain/                  # Domain layer
│   ├── models/              # Data models (Note)
│   └── repositories/        # Repository interfaces
└── presentation/            # Presentation layer
    ├── providers/           # State management (ChangeNotifier providers)
    ├── screens/             # App screens (HomeScreen, NoteEditorScreen)
    └── widgets/             # Reusable UI components
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/CustomNote.git
   cd CustomNote
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Architecture

### Core Layer
- **Constants**: Centralized app colors, strings, and dimensions
- **Themes**: Light, Dark, and Pastel theme configurations
- **Utils**: Date/time formatting utilities

### Domain Layer
- **Note Model**: Contains id, title, content, timestamps, and color tag
- **Repository Interfaces**: Defines contracts for data operations

### Data Layer
- **LocalStorageService**: Dummy in-memory storage (ready to be replaced with SQLite, Hive, etc.)

### Presentation Layer
- **Providers**: ThemeProvider and NotesProvider for state management
- **Widgets**: Reusable components (CustomAppBar, NoteCard, ColorPicker)
- **Screens**: HomeScreen and NoteEditorScreen

## Reusable Components

### CustomAppBar
A custom app bar with theme toggle and search functionality.

### NoteCard
A card widget for displaying note previews with color indicators.

### ColorPicker
A horizontal color picker for selecting note color tags.

## Dependencies

- `provider`: State management
- `uuid`: Unique ID generation
- `intl`: Date/time formatting

## Future Enhancements

- [ ] Persistent storage (SQLite/Hive)
- [ ] Note categories and folders
- [ ] Reminders and notifications
- [ ] Cloud backup and sync
- [ ] Rich text editing
- [ ] Note sharing

## License

This project is open source and available under the MIT License.
