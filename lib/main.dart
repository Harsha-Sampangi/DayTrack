import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/expense_provider.dart';
import 'providers/income_provider.dart';
import 'providers/task_provider.dart';
import 'providers/settings_provider.dart';
import 'services/hive_service.dart';
import 'services/notification_service.dart';

/// Application entry point.
///
/// 1. Initializes Hive (local database)
/// 2. Initializes notification service
/// 3. Sets up the Provider tree
/// 4. Launches the app
void main() async {
  // Ensure Flutter bindings are ready before async init
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait mode for consistent UX
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI style for dark theme
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color(0xFF0D0D0D),
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Initialize Hive (local database)
  await HiveService.init();

  // Initialize notification service
  await NotificationService.init();

  // Create providers and load initial data
  final expenseProvider = ExpenseProvider()..loadExpenses();
  final incomeProvider = IncomeProvider()..loadIncomes();
  final taskProvider = TaskProvider()..loadTasks();
  final settingsProvider = SettingsProvider()..loadSettings();

  // Run the app with Provider tree
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: expenseProvider),
        ChangeNotifierProvider.value(value: incomeProvider),
        ChangeNotifierProvider.value(value: taskProvider),
        ChangeNotifierProvider.value(value: settingsProvider),
      ],
      child: const App(),
    ),
  );
}
