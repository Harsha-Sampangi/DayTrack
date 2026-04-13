import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../core/utils/date_utils.dart';
import '../models/expense.dart';
import '../models/spending_limit.dart';
import '../services/hive_service.dart';
import '../services/notification_service.dart';

/// State management for expenses — CRUD operations and aggregations.
///
/// Listens to Hive box changes and notifies UI via [ChangeNotifier].
class ExpenseProvider extends ChangeNotifier {
  static const _uuid = Uuid();

  List<Expense> _expenses = [];

  /// All expenses, sorted newest first.
  List<Expense> get expenses => _expenses;

  /// Load expenses from Hive into memory.
  void loadExpenses() {
    _expenses = HiveService.getAllExpenses();
    notifyListeners();
  }

  // ── CRUD ─────────────────────────────────────────────────────────────

  /// Add a new expense and check spending limits.
  Future<void> addExpense({
    required double amount,
    required String category,
    required DateTime date,
    String notes = '',
  }) async {
    final expense = Expense(
      id: _uuid.v4(),
      amount: amount,
      category: category,
      date: date,
      notes: notes,
    );

    await HiveService.expenseBox.put(expense.id, expense);
    _expenses.insert(0, expense);
    _expenses.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();

    // Check spending limits after adding
    _checkSpendingLimits();
  }

  /// Delete an expense by its ID.
  Future<void> deleteExpense(String id) async {
    await HiveService.expenseBox.delete(id);
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  // ── Aggregations ─────────────────────────────────────────────────────

  /// Total expenses for today.
  double get todayTotal {
    return _expenses
        .where((e) => AppDateUtils.isToday(e.date))
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  /// Total expenses for the current week.
  double get weeklyTotal {
    return _expenses
        .where((e) => AppDateUtils.isThisWeek(e.date))
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  /// Total expenses for the current month.
  double get monthlyTotal {
    return _expenses
        .where((e) => AppDateUtils.isThisMonth(e.date))
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  /// Expenses grouped by category with totals (for pie chart).
  Map<String, double> get byCategory {
    final map = <String, double>{};
    for (final e in _expenses.where((e) => AppDateUtils.isThisMonth(e.date))) {
      map[e.category] = (map[e.category] ?? 0) + e.amount;
    }
    return map;
  }

  /// Daily totals for the current week (Mon → Sun) for bar chart.
  List<double> get weeklyDailyTotals {
    final weekDates = AppDateUtils.currentWeekDates();
    return weekDates.map((day) {
      return _expenses
          .where((e) =>
              e.date.year == day.year &&
              e.date.month == day.month &&
              e.date.day == day.day)
          .fold(0.0, (sum, e) => sum + e.amount);
    }).toList();
  }

  /// Last N expenses for dashboard display.
  List<Expense> recentExpenses({int count = 5}) {
    return _expenses.take(count).toList();
  }

  // ── Spending Limit Check ─────────────────────────────────────────────

  void _checkSpendingLimits() {
    final limit = HiveService.getSpendingLimit();
    if (!limit.notifyOnExceed) return;

    if (limit.hasDailyLimit && todayTotal > limit.dailyLimit) {
      NotificationService.showLimitExceeded(
        limitType: 'daily',
        spent: todayTotal,
        limit: limit.dailyLimit,
      );
    }

    if (limit.hasMonthlyLimit && monthlyTotal > limit.monthlyLimit) {
      NotificationService.showLimitExceeded(
        limitType: 'monthly',
        spent: monthlyTotal,
        limit: limit.monthlyLimit,
      );
    }
  }

  /// Get the current spending limit (for UI progress bars).
  SpendingLimit get spendingLimit => HiveService.getSpendingLimit();
}
