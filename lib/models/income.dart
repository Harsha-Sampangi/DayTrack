import 'package:hive_ce/hive.dart';
import '../core/constants/app_constants.dart';

part 'income.g.dart';

/// Income data model — stored in Hive.
///
/// Each income entry has an amount, source, and date.
/// Sources: Part-time, Freelance, Allowance, Stipend, Other.
@HiveType(typeId: 1) // AppConstants.incomeTypeId
class Income extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late double amount;

  /// One of [AppConstants.incomeSources].
  @HiveField(2)
  late String source;

  @HiveField(3)
  late DateTime date;

  @HiveField(4)
  late DateTime createdAt;

  Income({
    required this.id,
    required this.amount,
    required this.source,
    required this.date,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Income copyWith({
    String? id,
    double? amount,
    String? source,
    DateTime? date,
  }) {
    return Income(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      source: source ?? this.source,
      date: date ?? this.date,
      createdAt: createdAt,
    );
  }

  @override
  String toString() =>
      'Income(id: $id, amount: $amount, source: $source, date: $date)';
}
