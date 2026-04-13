/// Hive box names, type IDs, Categories, and other app-wide constants.
class AppConstants {
  AppConstants._();

  // ── Hive Box Names ────────────────────────────────────────────────────
  static const String expenseBox = 'expenses';
  static const String incomeBox = 'incomes';
  static const String taskBox = 'tasks';
  static const String settingsBox = 'settings';

  // ── Hive Type IDs (must be unique across all models) ──────────────────
  static const int expenseTypeId = 0;
  static const int incomeTypeId = 1;
  static const int taskTypeId = 2;
  static const int spendingLimitTypeId = 3;

  // ── Expense Categories ────────────────────────────────────────────────
  static const List<String> expenseCategories = [
    'Food',
    'Travel',
    'Shopping',
    'College',
    'Others',
  ];

  // ── Income Sources ────────────────────────────────────────────────────
  static const List<String> incomeSources = [
    'Part-time',
    'Freelance',
    'Allowance',
    'Stipend',
    'Other',
  ];

  // ── Priority Levels ───────────────────────────────────────────────────
  static const int priorityLow = 0;
  static const int priorityMedium = 1;
  static const int priorityHigh = 2;

  static const List<String> priorityLabels = ['Low', 'Medium', 'High'];

  // ── Notification IDs ──────────────────────────────────────────────────
  static const int dailyReminderNotifId = 9999;
  static const String notifChannelId = 'plm_notifications';
  static const String notifChannelName = 'Life Manager Alerts';

  // ── Secure Storage Keys ───────────────────────────────────────────────
  static const String pinKey = 'app_pin';
  static const String lockEnabledKey = 'lock_enabled';

  // ── Settings Keys (Hive) ──────────────────────────────────────────────
  static const String spendingLimitKey = 'spending_limit';
}
