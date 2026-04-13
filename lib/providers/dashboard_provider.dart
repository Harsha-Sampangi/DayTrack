import 'package:flutter/foundation.dart';
import '../providers/expense_provider.dart';
import '../providers/income_provider.dart';
import '../providers/task_provider.dart';

/// Combines data from expense, income, and task providers
/// to serve the dashboard screen with pre-computed values.
///
/// Not a standalone provider — it reads from the other three.
class DashboardProvider extends ChangeNotifier {
  final ExpenseProvider expenseProvider;
  final IncomeProvider incomeProvider;
  final TaskProvider taskProvider;

  DashboardProvider({
    required this.expenseProvider,
    required this.incomeProvider,
    required this.taskProvider,
  });

  // ── Dashboard Stats ──────────────────────────────────────────────────

  double get todayExpenses => expenseProvider.todayTotal;
  double get todayIncome => incomeProvider.todayTotal;
  int get pendingTasks => taskProvider.pendingCount;
  int get completedTasks => taskProvider.completedTodayCount;

  /// Monthly balance = income - expenses.
  double get monthlyBalance =>
      incomeProvider.monthlyTotal - expenseProvider.monthlyTotal;

  /// Whether the user is in the green (income > expenses) this month.
  bool get isPositiveBalance => monthlyBalance >= 0;

  /// Spending limit progress (0.0 – 1.0) for daily limit.
  double get dailyLimitProgress {
    final limit = expenseProvider.spendingLimit;
    if (!limit.hasDailyLimit) return 0;
    return (expenseProvider.todayTotal / limit.dailyLimit).clamp(0.0, 1.5);
  }

  /// Whether daily limit is exceeded.
  bool get isDailyLimitExceeded {
    final limit = expenseProvider.spendingLimit;
    return limit.hasDailyLimit && expenseProvider.todayTotal > limit.dailyLimit;
  }

  /// Refresh all data — call when navigating to dashboard.
  void refresh() {
    notifyListeners();
  }
}
