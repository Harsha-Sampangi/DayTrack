import 'package:intl/intl.dart';

/// Date helper utilities used throughout the app.
///
/// Named `AppDateUtils` to avoid conflict with Flutter's built-in `DateUtils`.
class AppDateUtils {
  AppDateUtils._();

  /// Whether [date] is today.
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Whether [date] falls within the current week (Monday to Sunday).
  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final end = start.add(const Duration(days: 7));
    return date.isAfter(start.subtract(const Duration(seconds: 1))) &&
        date.isBefore(end);
  }

  /// Whether [date] falls within the current month.
  static bool isThisMonth(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  /// Format as "12 Apr 2026".
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Format as "12 Apr".
  static String formatDateShort(DateTime date) {
    return DateFormat('dd MMM').format(date);
  }

  /// Format as "09:30 AM".
  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  /// Format as "Mon", "Tue", etc.
  static String dayOfWeekShort(DateTime date) {
    return DateFormat('E').format(date);
  }

  /// Get list of 7 dates for the current week (Mon → Sun).
  static List<DateTime> currentWeekDates() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(
      7,
      (i) => DateTime(monday.year, monday.month, monday.day + i),
    );
  }

  /// Strip time component — keep only year/month/day.
  static DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Whether [date] is before today (ignoring time).
  static bool isOverdue(DateTime date) {
    final todayStart = dateOnly(DateTime.now());
    return dateOnly(date).isBefore(todayStart);
  }

  /// Section header text for task grouping.
  static String sectionLabel(DateTime date) {
    if (isToday(date)) return 'Today';
    if (isOverdue(date)) return 'Overdue';
    return 'Upcoming';
  }

  /// Relative time label matching Figma (e.g., "2h ago", "Yesterday", "Apr 10").
  static String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return formatDateShort(date);
  }
}

