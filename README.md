<div align="center">
  
# 🚀 DayTrack
  
**A modern, offline-first Expense & Task Tracker built for students.**

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

</div>

---

## 📖 Short Description

**DayTrack** is a clean and intuitive personal life manager designed to help students track their daily expenses, manage their income, and stay on top of their tasks. With an offline-first architecture, beautiful visualizations, and robust security features (PIN/Biometric authentication), DayTrack ensures your personal data stays safe, private, and always accessible without relying on a network connection.

---

## ✨ Features

- **💰 Expense & Income Tracking**: Log daily transactions, categorize them with emojis, and monitor your monthly and daily spending limits.
- **✅ Task Management**: Stay organized with daily to-dos and upcoming tasks. Track your progress with visual indicators.
- **📊 Analytics & Charts**: Interactive charts to visualize your cash flow and budget health.
- **🔒 Security First**: Built-in PIN protection and biometric authentication using local auth.
- **📴 Offline First Data**: All data is securely stored locally using Hive CE. No cloud dependencies!
- **🔔 Reminders & Notifications**: Local push notifications to keep you reminded of your tasks.
- **🎨 Beautiful UI**: A polished, premium design featuring glassmorphism, dynamic gradients, and smooth animations.

---

## 📸 Screenshots Section

| Dashboard | Add Expense | Settings |
| :---: | :---: | :---: |
| ![Dashboard Placeholder](https://via.placeholder.com/250x500.png?text=Dashboard) | ![Add Expense Placeholder](https://via.placeholder.com/250x500.png?text=Add+Expense) | ![Settings Placeholder](https://via.placeholder.com/250x500.png?text=Settings) |

*(Replace the placeholder URLs above with actual paths to your screenshots, e.g., `assets/screenshots/dashboard.png`)*

---

## 🎥 Demo / Preview

*(Include a GIF or a link to a video preview of the app running)*

![App Demo Placeholder](https://via.placeholder.com/600x300.png?text=App+Demo+GIF)

---

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (v3.5.3+)
- **Language**: [Dart](https://dart.dev/)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Local Database**: [Hive CE](https://pub.dev/packages/hive_ce) (Offline-first NoSQL database)
- **Local Storage**: [Flutter Secure Storage](https://pub.dev/packages/flutter_secure_storage)
- **UI/Charts**: [FL Chart](https://pub.dev/packages/fl_chart), Cupertino Icons
- **Auth/Security**: [Local Auth](https://pub.dev/packages/local_auth)
- **Notifications**: [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)

---

## 🏛 Architecture Overview

DayTrack follows a structured **Feature-based & Layered Architecture** for scalability and maintainability:
- **Core**: Contains app-wide constants, color palettes, string resources, and shared utilities.
- **Models**: Defines the data structures (Hive TypeAdapters) for Income, Expense, Task, etc.
- **Providers**: Manages business logic, state, and database interactions.
- **Screens**: Houses the UI components, split by feature (Dashboard, Expense, Income, Task, Settings).
- **Services**: Manages background services, local notifications, and biometric authentication.
- **Widgets**: Reusable UI elements (tiles, buttons, bottom sheets).

---

## 📁 Folder Structure

```text
lib/
├── app.dart                   # Main App Widget & Theme Setup
├── main.dart                  # App Entry Point
├── core/
│   ├── constants/             # Colors, Strings, Dimensions
│   └── utils/                 # Formatters, Helpers
├── models/                    # Data models (Hive schemas)
├── providers/                 # State management controllers
├── screens/                   # UI Screens
│   ├── dashboard/
│   ├── expense/
│   ├── income/
│   ├── task/
│   └── settings/
├── services/                  # Notification & Auth Services
└── widgets/                   # Reusable UI components
```

---

## ⚙️ Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Harsha-Sampangi/DayTrack.git
   cd DayTrack
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate Hive Adapters:**
   If you make changes to models, you need to run the build runner:
   ```bash
   dart run build_runner build -d
   ```

---

## 🔑 Environment Variables

Since DayTrack is an offline-first app, it **does not require** a `.env` file or external API keys by default. All data remains securely stored on the device.

*(If Firebase or custom APIs are added in the future, document the `.env` requirements here).*

---

## 🚀 Running the App

To run the app on a connected device or emulator:

```bash
flutter run
```

---

## 🏗 Build Instructions

### APK / IPA Generation

**For Android (APK):**
```bash
flutter build apk --release
```
*The APK will be generated at `build/app/outputs/flutter-apk/app-release.apk`*

**For Android (App Bundle - AAB for Play Store):**
```bash
flutter build appbundle --release
```

**For iOS (IPA):**
```bash
flutter build ipa --release
```
*Note: Requires macOS and Xcode. Open the workspace in Xcode to configure signing profiles.*

---

## 📡 API Configuration

This application is **Offline-First**. No external API configuration is required.
If you plan to add cloud syncing in the future, configure the endpoints in the `lib/services/api_service.dart` (to be created).

---

## 🔐 Permissions Required

### Android (`android/app/src/main/AndroidManifest.xml`)
- `USE_BIOMETRIC`: For PIN/Fingerprint unlocking.
- `RECEIVE_BOOT_COMPLETED`: To reschedule local notifications after device reboot.
- `SCHEDULE_EXACT_ALARM`: For precise task reminders (Android 12+).
- `POST_NOTIFICATIONS`: For local push notifications (Android 13+).

### iOS (`ios/Runner/Info.plist`)
- `NSFaceIDUsageDescription`: For biometric authentication.
- Notifications permission config.

---

## 🧠 State Management

DayTrack uses **[Provider](https://pub.dev/packages/provider)** for state management.
We inject `ExpenseProvider`, `IncomeProvider`, `TaskProvider`, and `SettingsProvider` at the root of the app (`app.dart`) so they can be consumed by any widget in the tree using `Consumer` or `context.read()`.

---

## 📚 Third-Party Libraries

- **`hive_ce`**: Lightning-fast, lightweight NoSQL database.
- **`provider`**: Simple and robust state management.
- **`fl_chart`**: Used for rendering interactive pie and line charts.
- **`local_auth`**: Handles system-level biometrics (Face ID / Touch ID).
- **`flutter_local_notifications`**: Schedules and displays offline task reminders.
- **`flutter_secure_storage`**: Stores sensitive data like user PINs securely.

---

## 🧪 Testing

To run the unit and widget tests:

```bash
flutter test
```

---

## 🚀 Deployment

### Android Play Store
1. Update version number in `pubspec.yaml`.
2. Ensure you have a release keystore configured in `android/key.properties`.
3. Run `flutter build appbundle`.
4. Upload the generated `.aab` to the Google Play Console.

### iOS App Store
1. Update version number in `pubspec.yaml`.
2. Open `ios/Runner.xcworkspace` in Xcode.
3. Select your development team and provision profiles.
4. Run Product > Archive and distribute to App Store Connect.

---

## 🔄 CI/CD (Optional)

*(Placeholder for GitHub Actions or Codemagic configuration)*
- You can set up a GitHub Actions workflow `.github/workflows/flutter.yml` to automatically run tests and build release APKs on every push to the `main` branch.

---

## ⚡ Performance Optimizations

- **Constant Constructors**: `const` widgets are heavily utilized to prevent unnecessary widget rebuilds.
- **Efficient State**: Using `Consumer` selectively wraps only the parts of the UI that need to rebuild when state changes.
- **Lazy Loading**: `ListView.builder` is used for transaction and task lists to ensure smooth scrolling even with thousands of entries.
- **Hive Database**: Hive performs entirely in memory and flushes to disk, making read/write operations exceptionally fast.

---

## 🛡 Security Practices

- **Secure Storage**: The app uses `flutter_secure_storage` to securely persist user settings, including the hashed App PIN.
- **Local Auth Integration**: Users can optionally enable biometric locks to prevent unauthorized access to financial data.
- **No Cloud Data Leaks**: Since all data is stored via `Hive` on the local file system, data privacy is guaranteed.

---

## 🐛 Known Issues

- *(Add any currently tracked issues or bugs here)*
- Notification permissions might require manual approval on certain custom Android OS skins (e.g., MIUI, ColorOS).

---

## 🗺 Future Improvements / Roadmap

- [ ] **Cloud Syncing**: Add Firebase or Supabase to sync data across multiple devices.
- [ ] **Data Export**: Allow users to export expenses as a CSV or PDF report.
- [ ] **Dark Mode Toggle**: Implement a manual toggle for light/dark themes.
- [ ] **Multi-currency Support**: Allow switching between different currencies dynamically.

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the project.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a Pull Request.

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 👤 Author / Contact Information

**Harsha Sampangi**
- GitHub: [@Harsha-Sampangi](https://github.com/Harsha-Sampangi)
- Email: *(your-email@example.com)*
- LinkedIn: *(Link to your profile)*

---
*If you find this project helpful, please consider giving it a ⭐!*
