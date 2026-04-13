import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../core/utils/date_utils.dart';
import '../models/income.dart';
import '../services/hive_service.dart';

/// State management for income entries — CRUD and aggregations.
class IncomeProvider extends ChangeNotifier {
  static const _uuid = Uuid();

  List<Income> _incomes = [];

  /// All incomes, sorted newest first.
  List<Income> get incomes => _incomes;

  /// Load incomes from Hive into memory.
  void loadIncomes() {
    _incomes = HiveService.getAllIncomes();
    notifyListeners();
  }

  // ── CRUD ─────────────────────────────────────────────────────────────

  /// Add a new income entry.
  Future<void> addIncome({
    required double amount,
    required String source,
    required DateTime date,
  }) async {
    final income = Income(
      id: _uuid.v4(),
      amount: amount,
      source: source,
      date: date,
    );

    await HiveService.incomeBox.put(income.id, income);
    _incomes.insert(0, income);
    _incomes.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  /// Delete an income entry by its ID.
  Future<void> deleteIncome(String id) async {
    await HiveService.incomeBox.delete(id);
    _incomes.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  // ── Aggregations ─────────────────────────────────────────────────────

  /// Total income for today.
  double get todayTotal {
    return _incomes
        .where((i) => AppDateUtils.isToday(i.date))
        .fold(0.0, (sum, i) => sum + i.amount);
  }

  /// Total income for the current month.
  double get monthlyTotal {
    return _incomes
        .where((i) => AppDateUtils.isThisMonth(i.date))
        .fold(0.0, (sum, i) => sum + i.amount);
  }

  /// Last N incomes for display.
  List<Income> recentIncomes({int count = 5}) {
    return _incomes.take(count).toList();
  }
}
