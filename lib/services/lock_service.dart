import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import '../core/constants/app_constants.dart';

/// Service for app lock — PIN-based with optional biometric authentication.
///
/// PIN is stored encrypted via flutter_secure_storage.
/// Biometrics use the local_auth plugin.
class LockService {
  LockService._();

  static const _storage = FlutterSecureStorage();
  static final _localAuth = LocalAuthentication();

  // ── PIN Management ────────────────────────────────────────────────────

  /// Whether a PIN has been set.
  static Future<bool> isPinSet() async {
    final pin = await _storage.read(key: AppConstants.pinKey);
    return pin != null && pin.isNotEmpty;
  }

  /// Whether the app lock is enabled.
  static Future<bool> isLockEnabled() async {
    final val = await _storage.read(key: AppConstants.lockEnabledKey);
    return val == 'true';
  }

  /// Enable or disable the app lock.
  static Future<void> setLockEnabled(bool enabled) async {
    await _storage.write(
      key: AppConstants.lockEnabledKey,
      value: enabled.toString(),
    );
  }

  /// Save a new PIN (4-digit string).
  static Future<void> setPin(String pin) async {
    await _storage.write(key: AppConstants.pinKey, value: pin);
  }

  /// Verify the entered PIN against the stored PIN.
  static Future<bool> verifyPin(String enteredPin) async {
    final storedPin = await _storage.read(key: AppConstants.pinKey);
    return storedPin == enteredPin;
  }

  /// Remove the PIN and disable lock.
  static Future<void> removePin() async {
    await _storage.delete(key: AppConstants.pinKey);
    await setLockEnabled(false);
  }

  // ── Biometric Authentication ──────────────────────────────────────────

  /// Check if biometric authentication is available on this device.
  static Future<bool> isBiometricAvailable() async {
    try {
      final canCheck = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return canCheck && isDeviceSupported;
    } on PlatformException catch (e) {
      debugPrint('LockService: Biometric check failed — $e');
      return false;
    }
  }

  /// Authenticate using biometrics (fingerprint / face).
  /// Returns true if authentication succeeded.
  static Future<bool> authenticateWithBiometrics() async {
    try {
      return await _localAuth.authenticate(
        localizedReason: 'Authenticate to access Life Manager',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      debugPrint('LockService: Biometric auth failed — $e');
      return false;
    }
  }
}
