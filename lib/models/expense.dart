import 'package:hive_ce/hive.dart';
import '../core/constants/app_constants.dart';

part 'expense.g.dart';

/// Expense data model — stored in Hive.
///
/// Each expense has an amount, category, date, and optional notes.
/// Categories: Food, Travel, Shopping, College, Others.
@HiveType(typeId: 0) // AppConstants.expenseTypeId
class Expense extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late double amount;

  /// One of [AppConstants.expenseCategories].
  @HiveField(2)
  late String category;

  @HiveField(3)
  late DateTime date;

  @HiveField(4)
  late String notes;

  @HiveField(5)
  late DateTime createdAt;

  Expense({
    required this.id,
    required this.amount,
    required this.category,
    required this.date,
    this.notes = '',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Create a copy with optional field overrides.
  Expense copyWith({
    String? id,
    double? amount,
    String? category,
    DateTime? date,
    String? notes,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      createdAt: createdAt,
    );
  }

  @override
  String toString() =>
      'Expense(id: $id, amount: $amount, category: $category, date: $date)';
}
