import 'package:intl/intl.dart';

/// Currency formatting utilities — Indian Rupee (₹) only.
class CurrencyUtils {
  CurrencyUtils._();

  /// Indian Rupee formatter with commas (e.g. ₹1,250.00).
  static final _formatter = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  /// Compact formatter (e.g. ₹1.2K, ₹15L).
  static final _compactFormatter = NumberFormat.compactCurrency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 1,
  );

  /// Format a number as ₹1,250.00
  static String format(double amount) {
    return _formatter.format(amount);
  }

  /// Format compactly: ₹1.2K for large amounts, full format for small.
  static String formatCompact(double amount) {
    if (amount.abs() < 10000) return format(amount);
    return _compactFormatter.format(amount);
  }

  /// Format without decimals: ₹1,250
  static String formatWhole(double amount) {
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    ).format(amount);
  }

  /// Format with sign: +₹500 or -₹200
  static String formatSigned(double amount) {
    final prefix = amount >= 0 ? '+' : '';
    return '$prefix${format(amount)}';
  }
}
