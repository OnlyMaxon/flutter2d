# Flutter 2D - Play or Die 🎮

A fast-paced 2D arcade game built with Flutter. No registration, no login - just pure arcade action!

## About

**DODGE IT** is an intense arcade game where you must dodge falling objects and survive as long as possible. The game features:

- 🎯 Simple one-touch controls - swipe left or right to move
- 🚀 Fast-paced arcade gameplay
- 💯 Score tracking
- 🎨 Colorful graphics with glowing effects
- 📱 Works on Android, iOS, and Web
- 🔥 No registration required - just play!

## Game Rules

1. **Start the game** - Tap the "PLAY NOW" button
2. **Move your player** - Swipe left or right to dodge falling objects
3. **Survive** - Avoid all falling objects (red, yellow, and purple circles)
4. **Score points** - The longer you survive, the higher your score
5. **Game Over** - If you hit any object, it's game over!

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- For Android: Android Studio with Android SDK
- For iOS: Xcode (macOS only)
- For Web: Chrome or any modern browser

### Installation

1. Clone the repository:
```bash
git clone https://github.com/OnlyMaxon/flutter2d.git
cd flutter2d
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:

**For Android/iOS:**
```bash
flutter run
```

**For Web:**
```bash
flutter run -d chrome
```

**For specific device:**
```bash
flutter devices  # List available devices
flutter run -d <device_id>
```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web --release
```

## Project Structure

```
flutter2d/
├── lib/
│   └── main.dart          # Main game code
├── android/               # Android-specific files
├── ios/                   # iOS-specific files
├── web/                   # Web-specific files
├── test/                  # Unit tests
├── pubspec.yaml           # Project dependencies
└── README.md             # This file
```

## Features

### Implemented
- ✅ Menu screen with game title and start button
- ✅ Game screen with player control
- ✅ Falling objects with collision detection
- ✅ Score tracking system
- ✅ Game over screen with retry option
- ✅ Responsive design for different screen sizes
- ✅ Smooth animations and effects

### Arcade Experience
- **No Registration**: Jump straight into the action
- **No Login**: No barriers between you and the game
- **Instant Play**: Start playing in seconds
- **High Score Challenge**: Beat your own records
- **Play or Die**: Simple but addictive gameplay

## Technology Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **UI**: Material Design
- **Animation**: Flutter's built-in animation system
- **Platforms**: Android, iOS, Web

## Contributing

This is an arcade game project. Feel free to fork and create your own variations!

## License

This project is open source and available for educational purposes.

## Contact

Project Link: [https://github.com/OnlyMaxon/flutter2d](https://github.com/OnlyMaxon/flutter2d)

---

**Remember: PLAY OR DIE! 💀**