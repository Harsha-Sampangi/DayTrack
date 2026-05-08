import 'package:flutter/foundation.dart';
import '../models/spending_limit.dart';
import '../core/constants/app_constants.dart';
import '../services/hive_service.dart';
import '../services/lock_service.dart';

/// Manages app settings: spending limits, app lock, and preferences.
class SettingsProvider extends ChangeNotifier {
  SpendingLimit _spendingLimit = SpendingLimit();
  bool _isLockEnabled = false;
  bool _isPinSet = false;
  bool _isBiometricAvailable = false;
  String _userName = 'Student';

  // ── Getters ──────────────────────────────────────────────────────────

  SpendingLimit get spendingLimit => _spendingLimit;
  bool get isLockEnabled => _isLockEnabled;
  bool get isPinSet => _isPinSet;
  bool get isBiometricAvailable => _isBiometricAvailable;
  String get userName => _userName;

  // ── Initialization ───────────────────────────────────────────────────

  /// Load all settings from storage. Call once on app start.
  Future<void> loadSettings() async {
    _spendingLimit = HiveService.getSpendingLimit();
    _isLockEnabled = await LockService.isLockEnabled();
    _isPinSet = await LockService.isPinSet();
    _isBiometricAvailable = await LockService.isBiometricAvailable();
    _userName = HiveService.settingsBox.get(AppConstants.userNameKey, defaultValue: 'Student') as String;
    notifyListeners();
  }

  // ── Spending Limits ──────────────────────────────────────────────────

  /// Update the daily spending limit.
  Future<void> setDailyLimit(double limit) async {
    _spendingLimit = _spendingLimit.copyWith(dailyLimit: limit);
    await HiveService.saveSpendingLimit(_spendingLimit);
    notifyListeners();
  }

  /// Update the monthly spending limit.
  Future<void> setMonthlyLimit(double limit) async {
    _spendingLimit = _spendingLimit.copyWith(monthlyLimit: limit);
    await HiveService.saveSpendingLimit(_spendingLimit);
    notifyListeners();
  }

  /// Toggle notification on exceed.
  Future<void> toggleLimitNotification(bool enabled) async {
    _spendingLimit = _spendingLimit.copyWith(notifyOnExceed: enabled);
    await HiveService.saveSpendingLimit(_spendingLimit);
    notifyListeners();
  }

  // ── App Lock ─────────────────────────────────────────────────────────

  /// Enable app lock with a PIN.
  Future<void> enableLock(String pin) async {
    await LockService.setPin(pin);
    await LockService.setLockEnabled(true);
    _isLockEnabled = true;
    _isPinSet = true;
    notifyListeners();
  }

  /// Disable app lock and remove PIN.
  Future<void> disableLock() async {
    await LockService.removePin();
    _isLockEnabled = false;
    _isPinSet = false;
    notifyListeners();
  }

  /// Change the PIN (requires old PIN verification first).
  Future<bool> changePin(String oldPin, String newPin) async {
    final verified = await LockService.verifyPin(oldPin);
    if (!verified) return false;

    await LockService.setPin(newPin);
    notifyListeners();
    return true;
  }

  /// Verify the entered PIN.
  Future<bool> verifyPin(String pin) async {
    return await LockService.verifyPin(pin);
  }

  /// Attempt biometric authentication.
  Future<bool> authenticateBiometric() async {
    return await LockService.authenticateWithBiometrics();
  }

  // ── Profile ──────────────────────────────────────────────────────────

  /// Update the user's name.
  Future<void> setUserName(String name) async {
    _userName = name;
    await HiveService.settingsBox.put(AppConstants.userNameKey, name);
    notifyListeners();
  }
}
