# Admin Dashboard App

A Flutter-based admin dashboard application with responsive design.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK
- Android Studio or VS Code
- Xcode (for iOS development)

### Installing

1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```

2. Navigate to the project directory:
   ```bash
   cd admin_dashboard_app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

### Running the Application

To run the application on a connected device or emulator:

```bash
flutter run
```

To run on a specific platform:

```bash
# For Android
flutter run -d android

# For iOS
flutter run -d ios

# For web
flutter run -d chrome
```

### Building for Production

To build a release version of the application:

```bash
# For Android
flutter build apk

# For iOS
flutter build ios

# For web
flutter build web
```

## Project Structure

```
lib/
├── main.dart          # Entry point
├── responsive.dart     # Responsive design utilities
└── screens/
    ├── admin_page.dart      # Main admin dashboard
    ├── profile_page.dart    # User profile page
    └── Transaction_datails.dart # Transaction details page
```

