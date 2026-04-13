/// All user-facing strings in one place for easy localisation in the future.
class AppStrings {
  AppStrings._();

  // ── App ────────────────────────────────────────────────────────────────
  static const String appName = 'DayTrack';
  static const String appTagline = 'Track. Plan. Grow.';

  // ── Navigation tabs ────────────────────────────────────────────────────
  static const String navHome = 'Home';
  static const String navExpenses = 'Expenses';
  static const String navTasks = 'Tasks';
  static const String navAnalytics = 'Analytics';
  static const String navSettings = 'Settings';

  // ── Dashboard ──────────────────────────────────────────────────────────
  static const String todayExpenses = "Today's Expenses";
  static const String todayIncome = "Today's Income";
  static const String pendingTasks = 'Pending Tasks';
  static const String completedTasks = 'Completed';
  static const String monthlyBalance = 'Monthly Balance';
  static const String recentTransactions = 'Recent Transactions';
  static const String noTransactions = 'No transactions yet';

  // ── Expense ────────────────────────────────────────────────────────────
  static const String addExpense = 'Add Expense';
  static const String editExpense = 'Edit Expense';
  static const String amount = 'Amount';
  static const String category = 'Category';
  static const String date = 'Date';
  static const String notes = 'Notes (optional)';
  static const String expenseAdded = 'Expense added!';
  static const String expenseDeleted = 'Expense deleted';

  // ── Income ─────────────────────────────────────────────────────────────
  static const String addIncome = 'Add Income';
  static const String source = 'Source';
  static const String incomeAdded = 'Income added!';
  static const String incomeDeleted = 'Income deleted';

  // ── Tasks ──────────────────────────────────────────────────────────────
  static const String addTask = 'Add Task';
  static const String taskTitle = 'Task title';
  static const String priority = 'Priority';
  static const String time = 'Time';
  static const String taskAdded = 'Task added!';
  static const String taskDeleted = 'Task deleted';
  static const String taskCompleted = 'Task completed!';
  static const String today = 'Today';
  static const String upcoming = 'Upcoming';
  static const String overdue = 'Overdue';

  // ── Analytics ──────────────────────────────────────────────────────────
  static const String categoryBreakdown = 'Category Breakdown';
  static const String weeklyTrend = 'Weekly Trend';
  static const String taskStats = 'Task Completion';
  static const String thisWeek = 'This Week';
  static const String thisMonth = 'This Month';

  // ── Settings ───────────────────────────────────────────────────────────
  static const String settings = 'Settings';
  static const String spendingLimits = 'Spending Limits';
  static const String dailyLimit = 'Daily Limit';
  static const String monthlyLimit = 'Monthly Limit';
  static const String appLock = 'App Lock';
  static const String enablePin = 'Enable PIN Lock';
  static const String changePin = 'Change PIN';
  static const String enableBiometric = 'Use Biometrics';
  static const String about = 'About';

  // ── Notifications ──────────────────────────────────────────────────────
  static const String dailyReminderTitle = 'Expense Reminder 💰';
  static const String dailyReminderBody = "Don't forget to log today's expenses!";
  static const String limitExceededTitle = 'Spending Limit Exceeded ⚠️';
  static const String taskReminderTitle = 'Task Reminder 📋';

  // ── Common ─────────────────────────────────────────────────────────────
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String undo = 'Undo';
  static const String done = 'Done';
  static const String ok = 'OK';
}
