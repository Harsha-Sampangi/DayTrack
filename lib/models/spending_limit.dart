import 'package:hive_ce/hive.dart';

part 'spending_limit.g.dart';

/// Spending limit config — stored in Hive settings box.
///
/// Users can set a daily and/or monthly spending limit.
/// When exceeded, the app sends a notification.
@HiveType(typeId: 3) // AppConstants.spendingLimitTypeId
class SpendingLimit extends HiveObject {
  /// Daily spending limit in ₹. 0 means disabled.
  @HiveField(0)
  late double dailyLimit;

  /// Monthly spending limit in ₹. 0 means disabled.
  @HiveField(1)
  late double monthlyLimit;

  /// Whether to show a notification when limits are exceeded.
  @HiveField(2)
  late bool notifyOnExceed;

  SpendingLimit({
    this.dailyLimit = 0,
    this.monthlyLimit = 0,
    this.notifyOnExceed = true,
  });

  /// Whether a daily limit has been set.
  bool get hasDailyLimit => dailyLimit > 0;

  /// Whether a monthly limit has been set.
  bool get hasMonthlyLimit => monthlyLimit > 0;

  SpendingLimit copyWith({
    double? dailyLimit,
    double? monthlyLimit,
    bool? notifyOnExceed,
  }) {
    return SpendingLimit(
      dailyLimit: dailyLimit ?? this.dailyLimit,
      monthlyLimit: monthlyLimit ?? this.monthlyLimit,
      notifyOnExceed: notifyOnExceed ?? this.notifyOnExceed,
    );
  }
}
