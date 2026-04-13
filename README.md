# 📅 DayTrack — Expense & Task Tracker

> **Track. Plan. Grow.**
> A personal productivity app built with Flutter for students to manage daily expenses, income, and tasks — all offline, fast, and beautiful.

---

## 📸 Overview

DayTrack is a mobile-first personal life management application designed specifically for students. It combines an **expense tracker**, **income logger**, and **task manager** into one elegant, dark-themed app. Built offline-first using Hive, it works without an internet connection and keeps your data private on your device.

---

## ✨ Features

### 🏠 Dashboard
- **Welcome header** with the current date displayed prominently
- **Today's Expense card** — live total with optional daily budget progress bar
- **Today's Income card** — green-accented total for the day
- **Balance card** — full-width indigo gradient card showing net balance
- **Recent Transactions** — quick preview of latest expense entries
- **Today's Tasks** — checkbox preview of tasks due today (up to 3 shown)

### 💸 Expense Tracker
- Add expenses with **amount**, **category**, and **optional notes**
- **3-column emoji category grid** (Food 🍕, Shopping 🛒, Travel 🚗, College 📚, Health ❤️, Entertainment 📱, Others 💰)
- **Filter by period** — Daily / Weekly / Monthly views
- **Red gradient hero card** showing total spending for the selected period
- Swipe-to-delete with undo snackbar support
- **Spending limits** (daily & monthly) configurable from Settings with progress bar warning

### 💰 Income Tracker
- Log income with **source category** and **date**
- **Source categories**: Part-time, Freelance, Stipend, Allowance, Other
- **Green gradient hero card** showing monthly total
- Progress bar showing 75% monthly goal tracking

### ✅ Task Manager
- Add tasks with a **title**, **time**, and **priority level**
- **3 priority levels**: Low 🟢, Medium 🟡, High 🔴 — shown as glowing priority bars
- **Circular progress ring** (SVG-style custom painter) showing completion percentage
- Tasks grouped into **Today** and **Upcoming** sections
- Tap to toggle complete/incomplete — completed tasks show a strikethrough

### 📊 Analytics
- **Donut pie chart** — spending breakdown by category with legend, ₹ amounts, and percentages
- **Gradient bar chart** — weekly daily spending trend (Mon–Sun)
- **Summary stat cards** — Average Daily Spend and Task Completion Rate

### ⚙️ Settings
- **Profile card** with user avatar
- **Preferences** — Notifications toggle, Appearance & Language shortcuts
- **Security** — PIN lock with 4-digit keypad + biometric authentication (fingerprint/Face ID)
- **Spending Limits** — Set daily and monthly budget limits with dialog editors
- **App Lock Screen** — Custom PIN pad with shake animation on wrong PIN

---

## 🎨 Design System

DayTrack uses a custom Figma-inspired dark design system:

| Token | Value | Usage |
|---|---|---|
| Background | `#0D0D0D` | App background |
| Card | `#1A1A1A` | All card surfaces |
| Surface Variant | `#252525` | Input fields |
| Primary (Indigo) | `#6366F1` | Main accent, FAB, active nav |
| Violet | `#8B5CF6` | Gradient secondary, charts |
| Income (Emerald) | `#10B981` | Income amounts |
| Expense (Red) | `#EF4444` | Expense amounts |
| Warning (Amber) | `#F59E0B` | Medium priority, warnings |
| Text Primary | `#FAFAFA` | Main body text |
| Text Secondary | `#A0A0A0` | Labels and hints |
| Border | `rgba(255,255,255,0.08)` | All card borders |

### 🧩 UI Components
- **Floating Glassmorphism Bottom Nav** — pill-shaped with `BackdropFilter` blur and animated active indicator
- **Gradient FAB** — single Indigo→Violet gradient button opening an add-menu sheet
- **Hero Cards** — gradient-tinted stat cards with icon, label, and large amount value
- **Circular Progress Ring** — custom-painted arc with gradient stroke for task progress
- **Custom Toggle** — animated sliding toggle for Settings rows
- **Priority Bars** — glowing 4px vertical bars with color-coded BoxShadow per priority level
- **Category Grid** — 3-column emoji grid with animated border highlight on selection

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter (Dart) — latest stable |
| **Database** | Hive CE (Community Edition) — offline-first |
| **State Management** | Provider |
| **Charts** | fl_chart |
| **Notifications** | flutter_local_notifications |
| **Authentication** | local_auth (biometrics), flutter_secure_storage (PIN) |
| **Localization Ready** | dart:intl, all strings in `AppStrings` |
| **Currency** | Indian Rupee (₹) exclusively |

---

## 📁 Project Structure

```
lib/
├── main.dart                         # Entry point — Hive init, Provider setup
├── app.dart                          # MaterialApp + AppTheme + routing
│
├── core/
│   ├── constants/
│   │   ├── app_colors.dart           # Full color palette + gradient helpers
│   │   ├── app_strings.dart          # All user-facing strings (i18n-ready)
│   │   └── app_constants.dart        # Category lists, source lists, limits
│   ├── theme/
│   │   └── app_theme.dart            # ThemeData — dark theme, cards, inputs
│   └── utils/
│       ├── date_utils.dart           # Date helpers: isToday, timeAgo, formatDate
│       └── currency_utils.dart       # ₹ formatter
│
├── models/
│   ├── expense.dart                  # Expense Hive model
│   ├── expense.g.dart                # Generated adapter
│   ├── income.dart                   # Income Hive model
│   ├── income.g.dart                 # Generated adapter
│   ├── task_item.dart                # Task Hive model
│   ├── task_item.g.dart              # Generated adapter
│   ├── spending_limit.dart           # SpendingLimit model
│   └── spending_limit.g.dart         # Generated adapter
│
├── providers/
│   ├── expense_provider.dart         # Expense CRUD + totals + filters
│   ├── income_provider.dart          # Income CRUD + totals
│   ├── task_provider.dart            # Task CRUD + completion + grouping
│   └── settings_provider.dart        # PIN, biometric, limits
│
├── services/
│   ├── hive_service.dart             # Hive box registration
│   ├── notification_service.dart     # Local notification scheduling
│   └── lock_service.dart             # PIN verify + biometric auth
│
├── screens/
│   ├── main_shell.dart               # Bottom nav shell + FAB
│   ├── lock_screen.dart              # PIN pad lock screen
│   ├── dashboard/
│   │   └── dashboard_screen.dart     # Home dashboard
│   ├── expense/
│   │   ├── expense_list_screen.dart  # Expense list + filter
│   │   └── add_expense_screen.dart   # Add expense modal
│   ├── income/
│   │   ├── income_list_screen.dart   # Income list
│   │   └── add_income_screen.dart    # Add income modal
│   ├── task/
│   │   ├── task_list_screen.dart     # Task list + progress ring
│   │   └── add_task_screen.dart      # Add task modal
│   ├── analytics/
│   │   └── analytics_screen.dart     # Charts + stat cards
│   └── settings/
│       └── settings_screen.dart      # Settings + PIN + limits
│
└── widgets/
    ├── expense_tile.dart             # Expense list item
    ├── income_tile.dart              # Income list item
    ├── task_tile.dart                # Task list item with priority bar
    ├── stat_card.dart                # Gradient stat card
    ├── pie_chart_widget.dart         # Donut chart + legend
    ├── bar_chart_widget.dart         # Weekly gradient bar chart
    └── category_icon.dart            # Category icon + color mapper
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK **≥ 3.5.3** — [Install Flutter](https://docs.flutter.dev/get-started/install)
- Dart SDK **≥ 3.0**
- Android Studio / VS Code with Flutter plugin
- A physical device or emulator

### 1. Clone the Project

```bash
git clone <your-repository-url>
cd DayTrack
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Hive Adapters

```bash
dart run build_runner build --delete-conflicting-outputs
```

> This generates the `.g.dart` adapter files required by Hive to persist your models.

### 4. Run the App

```bash
# Run on connected Android/iOS device
flutter run

# Run on Chrome (web preview)
flutter run -d chrome

# Run on macOS desktop
flutter run -d macos
```

---

## 📱 Supported Platforms

| Platform | Status |
|---|---|
| Android | ✅ Fully supported |
| iOS | ✅ Fully supported |
| Web (Chrome) | ✅ Supported (preview mode) |
| macOS | ✅ Supported |

---

## 🗃️ Data Storage

All data is stored **100% locally** on the device using [Hive CE](https://pub.dev/packages/hive_ce):

| Box Name | Contents |
|---|---|
| `expenses` | Expense entries (amount, category, date, notes) |
| `incomes` | Income entries (amount, source, date) |
| `tasks` | Task items (title, time, priority, completion state) |
| `settings` | Spending limits, PIN hash, lock preference |

> No internet connection is required. No data leaves your device.

---

## 🔐 Security

- **4-digit PIN Lock** — hashed and stored in `FlutterSecureStorage` (encrypted on-device)
- **Biometric Auth** — Fingerprint / Face ID via `local_auth`, shown automatically if available
- **PIN shake animation** — visual feedback on incorrect PIN entry
- **Change PIN** — verify old PIN before setting a new one

---

## 📦 Key Dependencies

```yaml
hive_ce: ^2.5.0              # Offline database
hive_ce_flutter: ^2.1.0      # Flutter Hive integration
provider: ^6.1.2             # State management
fl_chart: ^0.69.0            # Charts
flutter_local_notifications: ^18.0.0  # Push notifications
local_auth: ^2.3.0           # Biometrics
flutter_secure_storage: ^9.2.2       # Encrypted secure storage
intl: ^0.19.0                # Date/number formatting
uuid: ^4.5.1                 # Unique IDs for entries
```

---

## 🏗️ Build for Release

### Android APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### iOS (requires macOS + Xcode)
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
# Output: build/web/
```

---

## 🤝 Contributing

This project is for personal/educational use. Feel free to fork and customise it for your own needs.

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m 'Add my feature'`
4. Push to the branch: `git push origin feature/my-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** — see [LICENSE](LICENSE) for details.

---

## 👤 Author

Built with ❤️ by a student, for students.

**DayTrack** — *Because every rupee and every minute counts.*
